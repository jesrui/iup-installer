# Windows installer for Iup

This repo contains scripts to download Iup 3.32 and its dependencies
from sourceforge and create Windows installers for the downloaded files.

The scripts generate two installers:

- IupSetup-VC17-3.32.exe for Microsoft Visual Studio 2022 C++ 17
- IupSetup-MinGW6-3.32.exe for MinGW64 gcc 6.4

Each installer includes static libs and dlls compiled for win32 x64 with either
vc17 or gcc 6.4, headers, Lua 5.4 bindings, examples and documentation.

See https://www.tecgraf.puc-rio.br/iup/ for more info.

# Development

Here are some quick notes on how to install the compiler and tools required to build
Iup programs:

## Developing with Visual Studio Community 2022

Tested with [Visual Studio 2023 Community C++ 17.12.3](https://visualstudio.microsoft.com/).

Module: Desktop Development with C++

Required Components:

- C++ compiler Tools
- Debugger
- Profiling Tools
- CMake Tools
- Windows 11 SDK

Required free space: 8.5 GB

Open "x64 Native Tools Command Prompt for VS 2022" to start building your program.

See `examples/vc17` for how to statically compile some sample applications.

## Developing with MinGW64

Tested with [MSYS2 MinGW64 gcc 14.2.0](https://www.msys2.org/)

After installing MSYS2, open a mingw64 terminal and install the gcc toolchain
needed to build IUP programs:

```
pacman -Syu
pacman -S mingw-w64-x86_64-toolchain
```

Note: make sure to install the mingw-w64-x86_64-toolchain package, which uses
the same msvcrt library as the IUP libs (the mingw-w64-ucrt-x86_64-toolchain
package uses the ucrt library, which is not compatible with the IUP libs).

See `examples/mingw6` for how to statically compile some sample applications.
