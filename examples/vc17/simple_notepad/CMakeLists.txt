cmake_minimum_required (VERSION 3.15)

project ("simple_notepad")

set(IUP_HOME "c:/Program Files/iup-vc17")

set(sources simple_notepad.c)

add_executable (simple_notepad ${sources})

target_include_directories(simple_notepad PRIVATE "${IUP_HOME}/include/iup")

find_library (Iup iup
	PATHS "${IUP_HOME}/lib/static/iup"
	REQUIRED NO_DEFAULT_PATH)

find_library (Iupimglib iupimglib
	PATHS "${IUP_HOME}/lib/static/iup"
	REQUIRED NO_DEFAULT_PATH)

find_library (Comctl32 comctl32
	REQUIRED)

# https://stackoverflow.com/questions/41528376/calling-c-maincrtstartup-function-from-assembly-masm-compatible
target_link_options(simple_notepad PRIVATE "/SUBSYSTEM:WINDOWS")

target_link_libraries(simple_notepad
	${Iup} ${Iupimglib}
	${Comctl32})
