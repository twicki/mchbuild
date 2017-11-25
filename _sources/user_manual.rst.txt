User Manual
===================

MCHBuild is a cmake based library that provides ways to describe the dependencies of a project 
and resolves and builds all the depencies with a single cmake configuration  and build step.
MCHBuild provides a set of cmake macros and functions and requires the use of a convention on 
how to write cmake project for all the projects in the dependency chain (except for the external 
dependencies). 

We will use the following figure to show how to build the dependency chain shown in the picture: 

.. figure:: figures/pack_dep.png
  
  Example of dependency chain of packages.  

In the example we assume ``packA``, ``packB``, ``packC`` are software packages of our organization
where we will directly use MCHBuild from the cmake configuration of the projects, while
``packExt1`` and ``packExt2`` are external packages where we can not modify the configuration & installation
infrastructure, and possibly could not make use of cmake.

Basic CMakeLists.txt
------------------------

It is assumed that each project (``packA``, ``packB``, ``packC``) will contain a cmake project, with a CMakeLists.txt
on the root directory of the project.

Like that, configuring ``packA`` using will require passing the dependent installation via cmake command line

.. code-block:: bash

  mkdir build; cd build
  cmake .. -DPACKB_ROOT=<packb_dir> -DPACKC_ROOT=<packc_dir>


Setup a cmake bundle
----------------------

Using MCHBuild will require creating a cmake file called a bundle. The bundle file
will define all the dependencies one by one. Therefore all the dependent project
(except the external dependencies) will require as well a bundle cmake file. 


The configuration of the bundle will be placed in
``<project>/bundle/CMakeLists.txt``

The bundle file contains the following structure:

* Locally clone the MCHBuild package. In order to do that there is a cmake macro in 
  mchbuild that helps cloning git repositories. Copy the macro ``mchbuildCloneRepository``
  into the current package and use it to clone mchbuild

.. code-block:: cmake

  include(mchbuildCloneRepository)

  set(PACKA_MCHBUILD_GIT_URL "https:///github.com/Meteoswiss-APN/mchbuild.git"
    CACHE PATH "URL of the dawn git repository to clone")
  set(PACKA_MCHBUILD_GIT_BRANCH "master" CACHE STRING "Branch of the dawn git repository to clone")
  mchbuild_clone_repository(NAME mchbuild URL ${PACKA_MCHBUILD_GIT_URL} BRANCH ${PACKA_MCHBUILD_GIT_BRANCH} SOURCE_DIR PACKA_MCHBUILD_SOURCE_DIR )

* We can add dependencies (other mchbuild projects) using the mchbuild_find_package:

  .. code-block:: cmake

    mchbuild_find_package(
      PACKAGE packB
      REQUIRED_VAR packB_DIR
      DEPENDS "packExt1" "packExt2"
      ADDITIONAL
        GIT_REPOSITORY "https://github.com/Meteoswiss-APN/packB.git"
        GIT_TAG "develop" 
        MCHBUILD_ROOT "${PACKA_MCHBUILD_SOURCE_DIR}"
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR> ...
    )
  
  Notice that mchbuild will require that the dependent package ``packB`` contains a bundle cmake project, 
  but not for the external dependencies ``packExt1`` and ``packExt2``.
  The REQUIRED_VAR will require the external project finder to set properly the ``packB_DIR`` variable, pointing to 
  the external project directory that contains the corresponding cmake Config file. 

* We can also add external dependencies using the mchbuild_find_package. See for example how to add dependency on ``packExt1``

  .. code-block:: cmake

    mchbuild_find_package(
      PACKAGE packExt1
      COMPONENTS "comp1" "comp2"
      REQUIRED_VARS PACKEXT1_ROOT
      ADDITIONAL
        DOWNLOAD_DIR ${MCHBUILD_DOWNLOAD_DIR}
        URL "http://sourceforge.net/projects/packExt1"
        URL_MD5 "7b493c08bc9557bbde7e29091f28b605" 
        BUILD_VERSION 1.58.0
    )

* Add the package itself, i.e. the root CMakeLists.txt (from the CMakeLists.txt in the bundle directory) as another external dependency

  .. code-block:: cmake

    mchbuild_find_package(
      PACKAGE packA
      FORWARD_VARS 
        BINARY_DIR packA_binary_dir
      DEPENDS "packB" "packC"
      ADDITIONAL
        SOURCE_DIR "${CMAKE_SOURCE_DIR}/../"
        MCHBUILD_ROOT "${GTCLANG_MCHBUILD_SOURCE_DIR}"
        CMAKE_ARGS -DpackB_DIR=${packB_DIR}
    )
 
  Since we are adding the top CMakeLists.txt of this project, packA, as a cmake external package, 
  instead of specifying a GIT url, here we simply specify the source directory that contains the top CMakeLists.txt
 
  Notice that here we use the cmake config directories obtained by previous calls to ``mchbuild_find_package`` 
  to set the cmake paths in  ``CMAKE_ARGS``

* The top CMakeLists.txt will contain some tests, but the bundle cmake project still does not contain any test. 
  Therefore, at the end of the bundle we forward the tests defined in the top CMakeLists.txt of ``packA`` to the bundle
  project

  .. code-block:: cmake

     add_test(NAME packA-tests 
       COMMAND  ${CMAKE_COMMAND} --build ${packA_binary_dir} --target test
     )

  Notice we make use of the cmake binary directory of packA, since the test targets are defined in that build directory.  


The external project files
-----------------------------
