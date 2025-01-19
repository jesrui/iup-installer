cmake_minimum_required (VERSION 3.15)

project ("simple_paint")

set(IUP_HOME "c:/Program Files/iup-vc17")

set(sources simple_paint.c)

add_executable (simple_paint ${sources})

target_include_directories(simple_paint PRIVATE "${IUP_HOME}/include/iup")
target_include_directories(simple_paint PRIVATE "${IUP_HOME}/include/im")
target_include_directories(simple_paint PRIVATE "${IUP_HOME}/include/cd")

find_library (Iup iup
	PATHS "${IUP_HOME}/lib/static/iup"
	REQUIRED NO_DEFAULT_PATH)

find_library (Iupimglib iupimglib
	PATHS "${IUP_HOME}/lib/static/iup"
	REQUIRED NO_DEFAULT_PATH)

find_library (Im im
	PATHS "${IUP_HOME}/lib/static/im"
	REQUIRED NO_DEFAULT_PATH)

find_library (Zlib1 zlib1
	PATHS "${IUP_HOME}/lib/static/im"
	REQUIRED NO_DEFAULT_PATH)

find_library (Im_process im_process
	PATHS "${IUP_HOME}/lib/static/im"
	REQUIRED NO_DEFAULT_PATH)

find_library (Iupim iupim
	PATHS "${IUP_HOME}/lib/static/iup"
	REQUIRED NO_DEFAULT_PATH)

find_library (Cd cd
	PATHS "${IUP_HOME}/lib/static/cd"
	REQUIRED NO_DEFAULT_PATH)

find_library (Freetype6 freetype6
	PATHS "${IUP_HOME}/lib/static/cd"
	REQUIRED NO_DEFAULT_PATH)

find_library (Iupcd iupcd
	PATHS "${IUP_HOME}/lib/static/iup"
	REQUIRED NO_DEFAULT_PATH)

find_library (Cdim cdim
	PATHS "${IUP_HOME}/lib/static/cd"
	REQUIRED NO_DEFAULT_PATH)

find_library (Comctl32 comctl32
	REQUIRED)

# https://stackoverflow.com/questions/41528376/calling-c-maincrtstartup-function-from-assembly-masm-compatible
target_link_options(simple_paint PRIVATE "/SUBSYSTEM:WINDOWS")

target_link_libraries(simple_paint
	${Iup} ${Iupimglib}
	${Im} ${Im_process} ${Iupim}
	${Cd} ${Iupcd} ${Cdim}
	${Zlib1}
	${Freetype6}
	${Comctl32})
