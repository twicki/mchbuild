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

# Download LLVM
ExternalProject_Add(
  llvm_clang_download_llvm
  DOWNLOAD_DIR ${GTCLANG_ALL_DOWNLOAD_DIR}
  URL ${llvm_clang_url_llvm}
  URL_MD5 ${llvm_clang_md5_llvm}
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
)

ExternalProject_Get_Property(llvm_clang_download_llvm SOURCE_DIR)
set(llvm_source_dir ${SOURCE_DIR})

# Download Clang
ExternalProject_Add(
  llvm_clang_download_clang
  DOWNLOAD_DIR ${GTCLANG_ALL_DOWNLOAD_DIR}/llvm/llvm/tools
  URL ${llvm_clang_url_clang}
  URL_MD5 ${llvm_clang_md5_clang}
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
)

ExternalProject_Get_Property(llvm_clang_download_clang SOURCE_DIR)
set(clang_source_dir ${SOURCE_DIR})

# Copy Clang to the lvm/tools directory
ExternalProject_Add(
  llvm_clang_copy_clang
  DOWNLOAD_COMMAND ""
  SOURCE_DIR ${clang_source_dir}
  PATCH_COMMAND ${CMAKE_COMMAND} -E make_directory ${llvm_source_dir}/tools/clang &&
                ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/ ${llvm_source_dir}/tools/clang/
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
)
add_dependencies(llvm_clang_copy_clang llvm_clang_download_llvm llvm_clang_download_clang)

# Download libc++
ExternalProject_Add(
  llvm_clang_download_libcxx
  DOWNLOAD_DIR ${GTCLANG_ALL_DOWNLOAD_DIR}/llvm/llvm/projects
  URL ${llvm_clang_url_libcxx}
  URL_MD5 ${llvm_clang_md5_libcxx}
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
)

ExternalProject_Get_Property(llvm_clang_download_libcxx SOURCE_DIR)
set(libcxx_source_dir ${SOURCE_DIR})

# Copy libc++ to the lvm/projects directory
ExternalProject_Add(
  llvm_clang_copy_libcxx
  DOWNLOAD_COMMAND ""
  SOURCE_DIR ${libcxx_source_dir}
  PATCH_COMMAND ${CMAKE_COMMAND} -E make_directory ${llvm_source_dir}/projects/libcxx &&
                ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/ ${llvm_source_dir}/projects/libcxx/
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
)
add_dependencies(llvm_clang_copy_libcxx llvm_clang_download_llvm llvm_clang_download_libcxx)

# Download libc++abi
ExternalProject_Add(
  llvm_clang_download_libcxxabi
  DOWNLOAD_DIR ${GTCLANG_ALL_DOWNLOAD_DIR}/llvm/llvm/projects
  URL ${llvm_clang_url_libcxxabi}
  URL_MD5 ${llvm_clang_md5_libcxxabi}
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
)

ExternalProject_Get_Property(llvm_clang_download_libcxxabi SOURCE_DIR)
set(libcxxabi_source_dir ${SOURCE_DIR})

# Copy libc++abi to the lvm/projects directory
ExternalProject_Add(
  llvm_clang_copy_libcxxabi
  DOWNLOAD_COMMAND ""
  SOURCE_DIR ${libcxxabi_source_dir}
  PATCH_COMMAND ${CMAKE_COMMAND} -E make_directory ${llvm_source_dir}/projects/libcxxabi &&
                ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/ ${llvm_source_dir}/projects/libcxxabi/
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
)
add_dependencies(llvm_clang_copy_libcxxabi llvm_clang_download_llvm llvm_clang_download_libcxxabi)

# Build LLVM/Clang
ExternalProject_Add(
  clang
  DOWNLOAD_COMMAND ""
  SOURCE_DIR ${llvm_source_dir}
  BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/llvm"
  INSTALL_DIR "${GTCLANG_ALL_INSTALL_PREFIX}/llvm"
  CMAKE_GENERATOR ${CMAKE_GENERATOR}
  CMAKE_ARGS
    ${GTCLANG_ALL_PACKAGE_CMAKE_ARGS}
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  DEPENDS
    llvm_clang_download_clang
    llvm_clang_download_llvm
    llvm_clang_download_libcxx
    llvm_clang_download_libcxxabi
    llvm_clang_copy_clang
    llvm_clang_copy_libcxx
    llvm_clang_copy_libcxxabi
)

ExternalProject_Get_Property(clang INSTALL_DIR)
set(LLVM_ROOT "${INSTALL_DIR}" CACHE INTERNAL "")

list(APPEND GTCLANG_ALL_THIRDPARTY_CMAKE_ARGS "-DLLVM_ROOT:PATH=${LLVM_ROOT}")
