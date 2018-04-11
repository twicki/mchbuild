##===-------------------------------------------------------------------------------------------===##
##                        _..._                                                          
##                     .-'_..._''.                                    .---._______       
##  __  __   ___     .' .'      '.\  .         /|                 .--.|   |\  ___ `'.    
## |  |/  `.'   `.  / .'           .'|         ||                 |__||   | ' |--.\  \   
## |   .-.  .-.   '. '            <  |         ||                 .--.|   | | |    \  '  
## |  |  |  |  |  || |             | |         ||  __             |  ||   | | |     |  ' 
## |  |  |  |  |  || |             | | .'''-.  ||/'__ '.   _    _ |  ||   | | |     |  | 
## |  |  |  |  |  |. '             | |/.'''. \ |:/`  '. ' | '  / ||  ||   | | |     ' .' 
## |  |  |  |  |  | \ '.          .|  /    | | ||     | |.' | .' ||  ||   | | |___.' /'  
## |__|  |__|  |__|  '. `._____.-'/| |     | | ||\    / '/  | /  ||__||   |/_______.'/   
##                     `-.______ / | |     | | |/\'..' /|   `'.  |    '---'\_______|/    
##                              `  | '.    | '.'  `'-'` '   .'|  '/                      
##                                 '---'   '---'         `-'  `--'                       
##
##  This file is distributed under the MIT License (MIT). 
##  See LICENSE.txt for details.
##
##===------------------------------------------------------------------------------------------===##

include(ExternalProject)
include(mchbuildSetExternalProperties)
include(mchbuildRequireOnlyOneOf)
include(mchbuildCheckRequiredVars)

set(DIR_OF_PROTO_EXTERNAL ${CMAKE_CURRENT_LIST_DIR})  

function(mchbuild_external_package)
  set(options)
  set(one_value_args URL URL_MD5 DOWNLOAD_DIR SOURCE_DIR GIT_REPOSITORY GIT_TAG MCHBUILD_ROOT)
  set(multi_value_args REQUIRED_VARS FORWARD_VARS CMAKE_ARGS)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  mchbuild_require_arg("MCHBUILD_ROOT" ${ARG_MCHBUILD_ROOT})
  mchbuild_require_only_one_of2(NAME1 "SOURCE_DIR" NAME2 "GIT"
         GROUP1 ${ARG_SOURCE_DIR}
         GROUP2 ${ARG_GIT_REPOSITORY} ${ARG_GIT_TAG})

  if(NOT("${ARG_UNPARSED_ARGUMENTS}" STREQUAL ""))
    message(FATAL_ERROR "invalid argument ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  mchbuild_set_external_properties(NAME "gtclang" 
    INSTALL_DIR install_dir 
    SOURCE_DIR source_dir
    BINARY_DIR binary_dir
  )

  list(APPEND ARG_CMAKE_ARGS "-DMCHBUILD_ROOT=${ARG_MCHBUILD_ROOT}")
  # set the install path to bundle project install dir
  set(ARG_CMAKE_ARGS ${ARG_CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>)

  # C++ protobuf
  if(ARG_GIT_REPOSITORY)
    mchbuild_clone_repository(NAME gtclang URL ${ARG_GIT_REPOSITORY} BRANCH ${ARG_GIT_TAG} SOURCE_DIR source_dir )

    set(options_file ${source_dir}/cmake/GTClangOptions.cmake)
    if(EXISTS ${options_file})
      include(${options_file})
    endif()

    foreach(option ${GTCLANG_OPTIONS})
      list(APPEND ARG_CMAKE_ARGS "-D${option}:BOOL=${${option}}")
    endforeach()

    ExternalProject_Add(gtclang
      PREFIX gtclang-prefix
      SOURCE_DIR ${ARG_SOURCE_DIR}
      SOURCE_SUBDIR "bundle"
      INSTALL_DIR "${install_dir}"
      CMAKE_ARGS ${ARG_CMAKE_ARGS} 
    )
  else()
    ExternalProject_Add(gtclang
      SOURCE_DIR ${ARG_SOURCE_DIR}
      INSTALL_DIR  ${CMAKE_INSTALL_PREFIX}
      BUILD_ALWAYS 1
      CMAKE_ARGS ${ARG_CMAKE_ARGS}
    )
  endif()

  mchbuild_check_required_vars(SET_VARS gtclang_DIR REQUIRED_VARS ${ARG_REQUIRED_VARS})
  ##TODO this is the same for all projects, we need to reuse this code
  if(DEFINED ARG_FORWARD_VARS)
    set(options)
    set(one_value_args BINARY_DIR)
    set(multi_value_args)
    cmake_parse_arguments(ARGFV "${options}" "${one_value_args}" "${multi_value_args}" ${ARG_FORWARD_VARS})

    if(NOT("${ARGFV_UNPARSED_ARGUMENTS}" STREQUAL ""))
      message(FATAL_ERROR "invalid argument for FORWARD_VARS ${ARGFV_UNPARSED_ARGUMENTS}")
    endif()

    set(${ARGFV_BINARY_DIR} ${binary_dir} PARENT_SCOPE)

  endif()

  set(gtclang_DIR "${binary_dir}/prefix/gtclang/cmake" CACHE INTERNAL "")

endfunction()
