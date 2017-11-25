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

include(CMakeParseArguments)

# mchbuild_set_external_properties
# ------------------------
#
# Try to find the package <PACKAGE>. If the package cannot be found via find_package, the 
# file "External_<PACKAGE>" will be included which should define a target <PACKAGE> (in all 
# lower case) which is used to built the package.
#
# The option USE_SYSTEM_<PACKAGE> indicates if the <PACKAGE> (all uppercase) is built or 
# supplied by the system. Note that USE_SYSTEM_<PACKAGE> does not honor the user setting if 
# the package cannot be found (i.e it will build it regardlessly).
#
#    PACKAGE:STRING=<>        - Name of the package (has to be the same name as used in 
#                               find_package).
#    PACKAGE_ARGS:LIST=<>     - Arguments passed to find_package.
#    FORWARD_VARS:LIST=<>     - List of variables which are appended (if defined) to the 
#                               MCHBUILD_THIRDPARTY_CMAKE_ARGS. This are usually the variables 
#                               which have an effect on the find_package call. For example, we may 
#                               want to forward BOOST_ROOT if it was supplied by the user. 
#    REQUIRED_VARS:LIST=<>    - Variables which need to be TRUE to consider the package as 
#                               found. By default we check that <PACKAGE>_FOUND is TRUE.
#    VERSION_VAR:STRING=<>    - Name of the variable which is defined by the find_package command
#                               to provide the version. By default we use <PACKAGE>_VERSION (or a 
#                               variation thereof).
#    BUILD_VERSION:STRING=<>  - Version of the package which is built (if required)
#    DEPENDS:LIST=<>          - Dependencies of this package.
#
function(mchbuild_set_external_properties)
  set(options)
  set(one_value_args NAME INSTALL_DIR SOURCE_DIR BINARY_DIR)
  set(multi_value_args)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  if(NOT("${ARG_UNPARSED_ARGUMENTS}" STREQUAL ""))
    message(FATAL_ERROR "invalid argument ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  if(DEFINED ARG_INSTALL_DIR) 
    set(${ARG_INSTALL_DIR} "${PROJECT_BINARY_DIR}/prefix/${ARG_NAME}" PARENT_SCOPE)
  endif()
  if(DEFINED ARG_SOURCE_DIR) 
    set(${ARG_SOURCE_DIR} "${CMAKE_CURRENT_BINARY_DIR}/${ARG_NAME}" PARENT_SCOPE)
  endif()
  #Assuming we always use the prefix mode 
  if(DEFINED ARG_BINARY_DIR)
    set(${ARG_BINARY_DIR} "${PROJECT_BINARY_DIR}/${ARG_NAME}-prefix/src/${ARG_NAME}-build/" PARENT_SCOPE)
  endif()


endfunction()
