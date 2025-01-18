#!/bin/bash
# Download zip files for iup 3.32 and dependencies from sourceforge
# and unpack them into a single dir tree.
#
# Included are static libs and dlls compiled for win32 x64 with mingw-w64 gcc 6.4,
# headers, Lua 5.4 bindings, examples and documentation.
#
#set -euxo pipefail
set -euo pipefail

iup_urls=(
    # static libs compiled for win32 x64 with mingw-w64, lua 5.4 bindings and their headers
    # im
    'https://master.dl.sourceforge.net/project/imtoolkit/3.15/Windows%20Libraries/Static/im-3.15_Win64_mingw6_lib.zip?viasf=1'
    # im lua bindings
    'https://master.dl.sourceforge.net/project/imtoolkit/3.15/Windows%20Libraries/Static/Lua54/im-3.15-Lua54_Win64_mingw6_lib.zip?viasf=1'
    # cd
    'https://master.dl.sourceforge.net/project/canvasdraw/5.14/Windows%20Libraries/Static/cd-5.14_Win64_mingw6_lib.zip?viasf=1'
    # cd lua bindings
    'https://master.dl.sourceforge.net/project/canvasdraw/5.14/Windows%20Libraries/Static/Lua54/cd-5.14-Lua54_Win64_mingw6_lib.zip?viasf=1'
    # iup
    'https://master.dl.sourceforge.net/project/iup/3.32/Windows%20Libraries/Static/iup-3.32_Win64_mingw6_lib.zip?viasf=1'
    # iup lua bindings
    'https://master.dl.sourceforge.net/project/iup/3.32/Windows%20Libraries/Static/Lua54/iup-3.32-Lua54_Win64_mingw6_lib.zip?viasf=1'
    # lua
    'https://master.dl.sourceforge.net/project/luabinaries/5.4.2/Windows%20Libraries/Static/lua-5.4.2_Win64_mingw6_lib.zip?viasf=1'

    # dlls compiled for win32 x64 with mingw-w64, lua 5.4 bindings and their headers and import libs
    # im
    'https://master.dl.sourceforge.net/project/imtoolkit/3.15/Windows%20Libraries/Dynamic/im-3.15_Win64_dllw6_lib.zip?viasf=1'
    # im lua bindings
    'https://master.dl.sourceforge.net/project/imtoolkit/3.15/Windows%20Libraries/Dynamic/Lua54/im-3.15-Lua54_Win64_dllw6_lib.zip?viasf=1'
    # cd
    'https://master.dl.sourceforge.net/project/canvasdraw/5.14/Windows%20Libraries/Dynamic/cd-5.14_Win64_dllw6_lib.zip?viasf=1'
    # cd lua bindings
    'https://master.dl.sourceforge.net/project/canvasdraw/5.14/Windows%20Libraries/Dynamic/Lua54/cd-5.14-Lua54_Win64_dllw6_lib.zip?viasf=1'
    # iup
    'https://master.dl.sourceforge.net/project/iup/3.32/Windows%20Libraries/Dynamic/iup-3.32_Win64_dllw6_lib.zip?viasf=1'
    # iup lua bindings
    'https://master.dl.sourceforge.net/project/iup/3.32/Windows%20Libraries/Dynamic/Lua54/iup-3.32-Lua54_Win64_dllw6_lib.zip?viasf=1'
    # lua
    'https://master.dl.sourceforge.net/project/luabinaries/5.4.2/Windows%20Libraries/Dynamic/lua-5.4.2_Win64_dllw6_lib.zip?viasf=1'

    # executables compiled for win32 x64 & lua 5.4 bindings
    # iup
    'https://master.dl.sourceforge.net/project/iup/3.32/Tools%20Executables/iup-3.32_Win64_bin.zip?viasf=1'
    # iup lua
    'https://master.dl.sourceforge.net/project/iup/3.32/Tools%20Executables/Lua54/iup-3.32-Lua54_Win64_bin.zip?viasf=1'

    # doc and examples
    # iup html
    'https://master.dl.sourceforge.net/project/iup/3.32/Docs%20and%20Sources/iup-3.32_Docs_html.zip?viasf=1'
    # iup chm
    'https://master.dl.sourceforge.net/project/iup/3.32/Docs%20and%20Sources/iup-3.32.chm?viasf=1'
    # iup pdf
    'https://master.dl.sourceforge.net/project/iup/3.32/Docs%20and%20Sources/iup-3.32.pdf?viasf=1'
)

# in the same order as iup_urls
iup_sha1sums=(
    825b69cd2ce54a724f2fe62505ddfc1b47f238bf  # im-3.15_Win64_mingw6_lib.zip
    f1fc562d53c4d44a0bb0feb0096c1b2368d1c497  # im-3.15-Lua54_Win64_mingw6_lib.zip
    1ae2ddd35b1114f1bf9c438245fa3cd4a3e9b9dd  # cd-5.14_Win64_mingw6_lib.zip
    7eb24b020245ab8b93765f769c0731bd837d80e5  # cd-5.14-Lua54_Win64_mingw6_lib.zip
    f1265f0887110b362178cf37621b658213943256  # iup-3.32_Win64_mingw6_lib.zip
    c10e8a6e89ed8eacf3b23a21f027f65dbf1ab8db  # iup-3.32-Lua54_Win64_mingw6_lib.zip
    b24d167fc7f931ca0f210e36aae28b9095d94144  # lua-5.4.2_Win64_mingw6_lib.zip
    7f0e368a5b58891a99b05504a7b401f1db5a546b  # im-3.15_Win64_dllw6_lib.zip
    a0d16cbd86be0a4df07718952ea359217d4b3150  # im-3.15-Lua54_Win64_dllw6_lib.zip
    12859043ab7723a863a9849774d19da0438ecb93  # cd-5.14_Win64_dllw6_lib.zip
    123b20cf9a06dfef4ff1101384d4482e07c53ae2  # cd-5.14-Lua54_Win64_dllw6_lib.zip
    f1944478d61fb3dd7b320fd5d5c92c613ea76f91  # iup-3.32_Win64_dllw6_lib.zip
    3eaa273049fd8988540c11b1d2665ede32758ad5  # iup-3.32-Lua54_Win64_dllw6_lib.zip
    e313a05e498b77b5e259737fe4ec851fe2b9d23e  # lua-5.4.2_Win64_dllw6_lib.zip
    e14f2df0f80c13f88e3d699c67c7cb03f80e7cd4  # iup-3.32_Win64_bin.zip
    e827ebdd776509bce43cc850fedc18000bcc2672  # iup-3.32-Lua54_Win64_bin.zip
    61ac23a2ed72a6bfe8f23727d8ec4954fab70f20  # iup-3.32_Docs_html.zip
    f1a88e93dc35c837c1f144b0b37f0cf64d403ffb  # iup-3.32.chm
    f4b08ff78244d46e018c30d5bd737354e92d0a95  # iup-3.32.pdf
)

CC=mingw6
DLL=dllw6

source install-iup.sh
