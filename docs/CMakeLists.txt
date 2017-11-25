set(PROJECT_ROOT ${PROJECT_SOURCE_DIR})
set(SPHINX_ROOT ${CMAKE_CURRENT_LIST_DIR})

# Extract CMake documentation
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake-modules-generate.cmake.in
             ${CMAKE_CURRENT_BINARY_DIR}/cmake-modules-generate.cmake @ONLY)
add_custom_target(MsbuildDocsCMakeModules
  COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake-modules-generate.cmake
  COMMENT "Configuring msbuild-cmake" VERBATIM
)

# Run sphinx
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/conf.py.in
               ${CMAKE_CURRENT_SOURCE_DIR}/conf.py @ONLY)

add_custom_target(MsbuildDocsSphinxHtml
   COMMAND ${SPHINX_EXECUTABLE} -b html -d ${CMAKE_BINARY_DIR}/sphinx/doctrees 
           ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_BINARY_DIR}/sphinx/html
   WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
   COMMENT "Generating sphinx HTML documentation" VERBATIM
   DEPENDS conf.py 
           index.rst 
)
add_dependencies(MsbuildDocsSphinxHtml MsbuildDocsCMakeModules)

# Copy HTML
add_custom_target(docs
 COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_BINARY_DIR}/sphinx/html 
                                            ${CMAKE_SOURCE_DIR}/docs/html
 WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
 COMMENT "Generating HTML documentation" VERBATIM
 DEPENDS MsbuildDocsSphinxHtml
)

add_custom_target(deploy-docs
  COMMAND ${BASH_EXECUTABLE} ${PROJECT_SOURCE_DIR}/scripts/gh-pages/deploy.sh
  WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
  COMMENT "Deploying documentation" VERBATIM
)

add_dependencies(deploy-docs docs)

