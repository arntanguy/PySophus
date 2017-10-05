cmake_minimum_required( VERSION 2.8 )

# Set the project name
project( PySophus )
set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_LIST_DIR}/cmake )
# XXX manually set, add FindEigency.cmake
set(EIGENCY_INCLUDE_DIR "/home/arnaud/src/python/eigency" CACHE STRING "Eigency include path")

add_definitions(-std=c++11)

# Include the CMake script UseCython.cmake.  This defines add_cython_module().
# Instruction for use can be found at the top of cmake/UseCython.cmake.
find_package( PythonInterp 2.7 REQUIRED )
find_package( PythonLibrary 2.7 REQUIRED )
include( UseCython )

include_directories(include)
include_directories("/usr/include/eigen3")
include_directories("include/Sophus")
include_directories(${EIGENCY_INCLUDE_DIR})
include_directories("/home/arnaud/.local/lib/python2.7/site-packages/numpy/core/include")

add_subdirectory( src )

# Unit tests
enable_testing()
add_subdirectory( tests )

