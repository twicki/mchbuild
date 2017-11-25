CMake Modules
=============

This section describes the CMake functionailty of Dawn and it's subprojects.

Installation
************

Add the ``<msbuild>/cmake/modules`` directory to the ``CMAKE_MODULE_PATH`` to use the functions, macros and modules:

.. code-block:: cmake

  list(APPEND CMAKE_MODULE_PATH "<msbuild>/cmake/modules")

Note that all `msbuild` projects contain a ``msbuild_cmake_init`` macro which tries to find the CMake modules of Msbuild.

.. code-block:: cmake

  include(MsbuildCMakeInit)
  msbuild_cmake_init()

Functions & Macros
******************

Each function and macro uses a `snake-case <https://en.wikipedia.org/wiki/Snake_case>`_ identifier and is defined in a spereate file using he corresponding `camel-case <https://en.wikipedia.org/wiki/Camel_case>`_ filename. For example, to use the function ``dawn_add_target_clean_all`` include the file ``DawnAddTargetCleanAll``.

.. code-block:: cmake

  include(DawnAddTargetCleanAll)
  dawn_add_target_clean_all()

.. toctree::
  :maxdepth: 1

  /cmake-modules/External_Boost
  /cmake-modules/External_Clang
  /cmake-modules/External_GTClang
  /cmake-modules/External_Protobuf
  /cmake-modules/External_dawn
  /cmake-modules/External_gtclang
  /cmake-modules/GTClangAllOptions
  /cmake-modules/msbuildAddCustomDummyTarget
  /cmake-modules/msbuildAddDependency
  /cmake-modules/msbuildAddExecutable
  /cmake-modules/msbuildAddLibrary
  /cmake-modules/msbuildAddOptionalDeps
  /cmake-modules/msbuildAddTargetClangFormat
  /cmake-modules/msbuildAddTargetCleanAll
  /cmake-modules/msbuildAddUnittest
  /cmake-modules/msbuildCMakeInit
  /cmake-modules/msbuildCheckAndSetCXXFlag
  /cmake-modules/msbuildCheckCXXFlag
  /cmake-modules/msbuildCheckInSourceBuild
  /cmake-modules/msbuildCheckRequiredVars
  /cmake-modules/msbuildCheckVarsAreDefined
  /cmake-modules/msbuildCloneRepository
  /cmake-modules/msbuildCombineLibraries
  /cmake-modules/msbuildConfigureFile
  /cmake-modules/msbuildCreatePackageString
  /cmake-modules/msbuildExportPackage
  /cmake-modules/msbuildFindPackage
  /cmake-modules/msbuildFindPythonModule
  /cmake-modules/msbuildGenerateCMakeScript
  /cmake-modules/msbuildGetArchitectureInfo
  /cmake-modules/msbuildGetCacheVariables
  /cmake-modules/msbuildGetCompilerInfo
  /cmake-modules/msbuildGetGitHeadRevision
  /cmake-modules/msbuildGetPlatformInfo
  /cmake-modules/msbuildGetScriptDir
  /cmake-modules/msbuildIncludeGuard
  /cmake-modules/msbuildMakeCMakeScript
  /cmake-modules/msbuildMakePackageInfo
  /cmake-modules/msbuildMakeStringPair
  /cmake-modules/msbuildReportResult
  /cmake-modules/msbuildRequireArg
  /cmake-modules/msbuildRequireOnlyOneOf
  /cmake-modules/msbuildSetCXXStandard
  /cmake-modules/msbuildSetDownloadDir
  /cmake-modules/msbuildSetExternalProperties

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
