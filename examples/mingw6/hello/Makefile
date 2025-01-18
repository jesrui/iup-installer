LDLIBS= -liup -lkernel32 -luser32 -lgdi32 -lwinspool -lcomdlg32 -ladvapi32 -lshell32 -lole32 -loleaut32 -luuid -lcomctl32
LDFLAGS= -Wl,-subsystem,windows -L "c:\Program Files\iup-mingw6\lib\static\iup" -static -static-libgcc
CFLAGS= -I "c:\Program Files\iup-mingw6\include\iup" 

example2_1.exe: example2_1.o
	$(CC) -o $@ $(LDFLAGS) $^ $(LDLIBS)
