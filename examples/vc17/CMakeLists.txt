cmake_minimum_required(VERSION 3.15)
cmake_policy(SET CMP0091 NEW)
project(IupExamples LANGUAGES C CXX)

# Link statically
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded")

add_subdirectory(hello)
add_subdirectory(simple_notepad)
add_subdirectory(simple_paint)
