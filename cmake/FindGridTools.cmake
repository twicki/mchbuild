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

if( NOT GRIDTOOLS_FOUND )

  find_path( GRIDTOOLS_INCLUDE_DIR 
             NAMES gridtools.hpp
             PATHS 
                ${CMAKE_INSTALL_PREFIX}
                "${GRIDTOOLS_PATH}"
                "${GRIDTOOLS_ROOT}"
                ENV GRIDTOOLS_PATH 
            PATH_SUFFIXES include
  )

  include(FindPackageHandleStandardArgs)

  # handle the QUIETLY and REQUIRED arguments and set GRIDTOOLS_FOUND to TRUE
  find_package_handle_standard_args( gridtools DEFAULT_MSG
                                     GRIDTOOLS_INCLUDE_DIR )

  mark_as_advanced( GRIDTOOLS_INCLUDE_DIRS GRIDTOOLS_LIBRARIES )

  set( GridTools_FOUND ${GRIDTOOLS_FOUND} )
  set( GRIDTOOLS_INCLUDE_DIRS 
    ${GRIDTOOLS_INCLUDE_DIR}
  )
endif()

