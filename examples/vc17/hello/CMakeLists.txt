# Example of static compilation
# -----------------------------
# Instructions:
# open a "x64 Native Tools Command Prompt for VS 2022"
# cd examples/hello
# mkdir build
# cd build
# cmake -G Ninja -DCMAKE_BUILD_TYPE=Release ..
# ninja
cmake_minimum_required (VERSION 3.8)

project ("hello")

set(IUP_HOME "c:/Program Files/iup-vc17")

set(sources example2_1.c)

add_executable (hello ${sources})

target_include_directories(hello PRIVATE "${IUP_HOME}/include/iup")

find_library (Iup iup
	PATHS "${IUP_HOME}/lib/static/iup"
	REQUIRED NO_DEFAULT_PATH)

find_library (Comctl32 comctl32
	REQUIRED)

# https://stackoverflow.com/questions/41528376/calling-c-maincrtstartup-function-from-assembly-masm-compatible
target_link_options(hello PRIVATE "/SUBSYSTEM:WINDOWS")

target_link_libraries(hello
	${Iup}
	${Comctl32})
