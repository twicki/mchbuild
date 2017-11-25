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

#.rst:
# mchbuild_cmake_init
# --------------------
#
# Add the necessary paths to ``CMAKE_MODULE_PATH`` to use the functions, macros and modules of the 
# ``mchbuild`` project. To find the ``mchbuild`` modules the following directories are searched:
#
#  1. Check for ``MCHBUILD_ROOT`` (pointing to the root folder of the installation)
#  2. Check for ``mchbuild_DIR`` (pointing to the directory containing ``mchbuildConfig.cmake``, equivalent 
#     to ``${CMAKE_ROOT}/cmake``).
#  3. Check ``${CMAKE_CURRENT_LIST_DIR}/../mchbuild``
#
# where ``CMAKE_CURRENT_LIST_DIR`` is the directory of the listfile currently being processed. Note 
# that this only checks for the CMake directory in thus also usuable with the source directory mchbuild. 
#
# .. code-block:: cmake
#
#  include(mchbuildCMakeInit)
#  mchbuild_cmake_init()
#
macro(mchbuild_cmake_init)
  set(mchbuild_cmake_dir)
  
  # If mchbuild_DIR points to the root directory (instead of <mchbuild-dir>/cmake), we correct this here
  get_filename_component(mchbuild_config_file "${mchbuild_DIR}/cmake/mchbuildConfig.cmake" ABSOLUTE)
  if(DEFINED mchbuild_DIR AND EXISTS "${mchbuild_config_file}")
    set(mchbuild_DIR "${mchbuild_DIR}/cmake" CACHE PATH "Path to mchbuildConfig.cmake" FORCE)
  endif()  

  if(DEFINED mchbuild_ROOT)
    set(mchbuild_cmake_dir "${MCHBUILD_ROOT}/cmake/modules")
  elseif(NOT "$ENV{MCHBUILD_ROOT}" STREQUAL "")
    set(mchbuild_cmake_dir "$ENV{MCHBUILD_ROOT}/cmake/modules")
  elseif(DEFINED mchbuild_DIR)
    set(mchbuild_cmake_dir "${mchbuild_DIR}/modules")
  elseif(NOT "$ENV{mchbuild_DIR}" STREQUAL "")
    set(mchbuild_cmake_dir "$ENV{mchbuild_DIR}/modules")
  elseif(EXISTS "${CMAKE_CURRENT_LIST_DIR}/../mchbuild")
    set(mchbuild_cmake_dir "${CMAKE_CURRENT_LIST_DIR}/../mchbuild/cmake/modules")
    message(FATAL_ERROR "Could NOT find mchbuild. (Try setting mchbuild_ROOT in the env)")
  endif()

  get_filename_component(mchbuild_cmake_dir ${mchbuild_cmake_dir} ABSOLUTE)
  
  # Sanity check the CMake directory
  if(NOT EXISTS ${mchbuild_cmake_dir})
    message(FATAL_ERROR "Invalid mchbuild directory: ${mchbuild_cmake_dir} (missing mchbuild/cmake/modules)")
  endif()

  list(APPEND CMAKE_MODULE_PATH "${mchbuild_cmake_dir}")
endmacro()
