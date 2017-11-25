Installation & Use
===================

Add the ``<mchbuild>/cmake/modules`` directory to the ``CMAKE_MODULE_PATH`` to use the functions, macros and modules:

.. code-block:: cmake

  list(APPEND CMAKE_MODULE_PATH "<mchbuild>/cmake/")

Note that all `mchbuild` projects contain a ``mchbuild_cmake_init`` macro which tries to find the CMake modules of MCHbuild.

.. code-block:: cmake

  include(MCHbuildCMakeInit)
  mchbuild_cmake_init()


.. include:: user_manual.rst


CMake Modules Reference
=========================

This section describes the CMake functionailty of MCHBuild.

Functions & Macros
******************

Each function and macro uses a `snake-case <https://en.wikipedia.org/wiki/Snake_case>`_ identifier and is defined in a separate file using the corresponding `camel-case <https://en.wikipedia.org/wiki/Camel_case>`_ filename. For example, to use the function ``mchbuild_add_target_clean_all`` include the file ``mchbuildAddTargetCleanAll`` as follows.

.. code-block:: cmake

    include(DawnAddTargetCleanAll)
    mchbuild_add_target_clean_all()

List of all functions and macros

.. toctree::
  :maxdepth: 1

  /cmake-modules/External_Boost
  /cmake-modules/External_Clang
  /cmake-modules/External_GTClang
  /cmake-modules/External_Protobuf
  /cmake-modules/External_dawn
  /cmake-modules/External_gridtools
  /cmake-modules/External_gtclang
  /cmake-modules/GTClangAllOptions
  /cmake-modules/mchbuildAddCustomDummyTarget
  /cmake-modules/mchbuildAddDependency
  /cmake-modules/mchbuildAddExecutable
  /cmake-modules/mchbuildAddLibrary
  /cmake-modules/mchbuildAddOptionalDeps
  /cmake-modules/mchbuildAddTargetClangFormat
  /cmake-modules/mchbuildAddTargetCleanAll
  /cmake-modules/mchbuildAddUnittest
  /cmake-modules/mchbuildCMakeInit
  /cmake-modules/mchbuildCheckAndSetCXXFlag
  /cmake-modules/mchbuildCheckCXXFlag
  /cmake-modules/mchbuildCheckInSourceBuild
  /cmake-modules/mchbuildCheckRequiredVars
  /cmake-modules/mchbuildCheckVarsAreDefined
  /cmake-modules/mchbuildCloneRepository
  /cmake-modules/mchbuildCombineLibraries
  /cmake-modules/mchbuildConfigureFile
  /cmake-modules/mchbuildCreatePackageString
  /cmake-modules/mchbuildEnableFullRPATH
  /cmake-modules/mchbuildExportOptions
  /cmake-modules/mchbuildExportPackage
  /cmake-modules/mchbuildFindPackage
  /cmake-modules/mchbuildFindPythonModule
  /cmake-modules/mchbuildGenerateCMakeScript
  /cmake-modules/mchbuildGetArchitectureInfo
  /cmake-modules/mchbuildGetCacheVariables
  /cmake-modules/mchbuildGetCompilerInfo
  /cmake-modules/mchbuildGetGitHeadRevision
  /cmake-modules/mchbuildGetPlatformInfo
  /cmake-modules/mchbuildGetScriptDir
  /cmake-modules/mchbuildIncludeGuard
  /cmake-modules/mchbuildMakeCMakeScript
  /cmake-modules/mchbuildMakePackageInfo
  /cmake-modules/mchbuildMakeStringPair
  /cmake-modules/mchbuildReportResult
  /cmake-modules/mchbuildRequireArg
  /cmake-modules/mchbuildRequireOnlyOneOf
  /cmake-modules/mchbuildSetCXXStandard
  /cmake-modules/mchbuildSetDownloadDir
  /cmake-modules/mchbuildSetExternalProperties


Modules
*******

Load settings for an external project via `find_package <https://cmake.org/cmake/help/v3.0/command/find_package.html>`_.


.. toctree::
  :maxdepth: 1

  /cmake-modules/FindClang
  /cmake-modules/FindGridTools
  /cmake-modules/FindLLVM
  /cmake-modules/FindSphinx
  /cmake-modules/Findbash
  /cmake-modules/Findccache
  /cmake-modules/Findclang-format
