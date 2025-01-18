# simple_notepad.c from iup tutorial
# See https://iup.sourceforge.net/en/tutorial/tutorial3.html

LDLIBS= -liup -liupimglib -lkernel32 -luser32 -lgdi32 -lwinspool -lcomdlg32 -ladvapi32 -lshell32 -lole32 -loleaut32 -luuid -lcomctl32
LDFLAGS= -Wl,-subsystem,windows -L "c:\Program Files\iup-mingw6\lib\static\iup" -static -static-libgcc
CFLAGS= -I "c:\Program Files\iup-mingw6\include\iup" 

simple_notepad.exe: simple_notepad.o
	$(CC) -o $@ $(LDFLAGS) $^ $(LDLIBS)
