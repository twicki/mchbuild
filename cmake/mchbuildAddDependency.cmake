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

# mchbuild_clone_repository
# ----------------------------
#
# This will make sure the repository NAME exists and, if not, will clone the branch BRANCH 
# from the git repository given by URL.
#
# This will define the variable MCHBUILD_<NAME>_SOURCE_DIR (where <NAME> is the passed NAME 
# in all uppercase) which contains the path to the source of the repository NAME.
#
#    NAME:STRING=<>       - Name of the repository
#    URL:STRING=<>        - Version of the package
#    BRANCH:STRING=<>     - Do we use the system version of the package?
#
function(mchbuild_add_dependency)
  set(options)
  set(one_value_args NAME URL BRANCH)
  set(multi_value_args)
  cmake_parse_arguments(ARG "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  string(TOUPPER ${ARG_NAME} upper_name)
  set(source_dir "${CMAKE_SOURCE_DIR}/${ARG_NAME}")

  include("thirdparty/mchbuildAdd${ARG_NAME}")
endfunction()
