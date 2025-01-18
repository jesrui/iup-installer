# simple_paint.c from iup tutorial
# See https://iup.sourceforge.net/en/tutorial/tutorial4.html

IUP_HOME= c:\Program Files\iup-mingw6
LDLIBS= -liup -liupimglib -liupim -liupcd -lcd -lcdim -lim -lim_process -lz -lfreetype6 
LDLIBS+= -lkernel32 -luser32 -lgdi32 -lwinspool -lcomdlg32 -ladvapi32 -lshell32 -lole32 -loleaut32 -luuid -lcomctl32
LDFLAGS= -Wl,-subsystem,windows 
LDFLAGS+= -static -static-libgcc -static-libstdc++
LDFLAGS+= -L "$(IUP_HOME)\lib\static\iup"
LDFLAGS+= -L "$(IUP_HOME)\lib\static\im"
LDFLAGS+= -L "$(IUP_HOME)\lib\static\cd"
CFLAGS= -I "$(IUP_HOME)\include\iup" 
CFLAGS+= -I "$(IUP_HOME)\include\im" 
CFLAGS+= -I "$(IUP_HOME)\include\cd" 

simple_paint.exe: simple_paint.o
	$(CXX) -o $@ $(LDFLAGS) $^ $(LDLIBS)
