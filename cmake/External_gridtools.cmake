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
  set(one_value_args DOWNLOAD_DIR GIT_REPOSITORY GIT_TAG MCHBUILD_ROOT)
  set(multi_value_args REQUIRED_VARS CMAKE_ARGS)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  mchbuild_require_arg("MCHBUILD_ROOT" ${ARG_MCHBUILD_ROOT})
  mchbuild_require_arg("GIT_REPOSITORY" ${ARG_GIT_REPOSITORY})

  if(NOT("${ARG_UNPARSED_ARGUMENTS}" STREQUAL ""))
    message(FATAL_ERROR "invalid argument ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  mchbuild_set_external_properties(NAME "gridtools" 
    INSTALL_DIR install_dir 
    SOURCE_DIR source_dir)

  list(APPEND ARG_CMAKE_ARGS -DMCHBUILD_ROOT=${ARG_MCHBUILD_ROOT} -DSTRUCTURED_GRID=ON -DDISABLE_TESTING=ON)

  # set the install path to bundle project install dir
  set(ARG_CMAKE_ARGS ${ARG_CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>)

  # C++ protobuf
  ExternalProject_Add(gridtools
    DOWNLOAD_DIR ${ARG_DOWNLOAD_DIR}
    GIT_REPOSITORY ${ARG_GIT_REPOSITORY}
    GIT_TAG ${ARG_GIT_TAG}
    SOURCE_DIR "${source_dir}"
    INSTALL_DIR "${install_dir}"
    CMAKE_ARGS ${ARG_CMAKE_ARGS} 
  )

  mchbuild_check_required_vars(SET_VARS "GridTools_DIR" REQUIRED_VARS ${ARG_REQUIRED_VARS})
  set(GridTools_DIR "${install_dir}" CACHE INTERNAL "")

endfunction()
