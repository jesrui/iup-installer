#!/bin/bash
# Download zip files for iup 3.32 and dependencies from sourceforge
# and unpack them into a single dir tree.
#
# Included are static libs and dlls compiled for win32 x64 with vc17,
# headers, Lua 5.4 bindings, examples and documentation.
#
#set -euxo pipefail
set -euo pipefail

iup_urls=(
    # static libs compiled for win32 x64 with vc17, lua 5.4 bindings and their headers
    # im
    'https://master.dl.sourceforge.net/project/imtoolkit/3.15/Windows%20Libraries/Static/im-3.15_Win64_vc17_lib.zip?viasf=1'
    # im lua bindings
    'https://master.dl.sourceforge.net/project/imtoolkit/3.15/Windows%20Libraries/Static/Lua54/im-3.15-Lua54_Win64_vc17_lib.zip?viasf=1'
    # cd
    'https://master.dl.sourceforge.net/project/canvasdraw/5.14/Windows%20Libraries/Static/cd-5.14_Win64_vc17_lib.zip?viasf=1'
    # cd lua bindings
    'https://master.dl.sourceforge.net/project/canvasdraw/5.14/Windows%20Libraries/Static/Lua54/cd-5.14-Lua54_Win64_vc17_lib.zip?viasf=1'
    # iup
    'https://master.dl.sourceforge.net/project/iup/3.32/Windows%20Libraries/Static/iup-3.32_Win64_vc17_lib.zip?viasf=1'
    # iup lua bindings
    'https://master.dl.sourceforge.net/project/iup/3.32/Windows%20Libraries/Static/Lua54/iup-3.32-Lua54_Win64_vc17_lib.zip?viasf=1'
    # lua
    'https://master.dl.sourceforge.net/project/luabinaries/5.4.2/Windows%20Libraries/Static/lua-5.4.2_Win64_vc17_lib.zip?viasf=1'

    # dlls compiled for win32 x64 with vc17, lua 5.4 bindings and their headers and import libs
    # im
    'https://master.dl.sourceforge.net/project/imtoolkit/3.15/Windows%20Libraries/Dynamic/im-3.15_Win64_dll17_lib.zip?viasf=1'
    # im lua bindings
    'https://master.dl.sourceforge.net/project/imtoolkit/3.15/Windows%20Libraries/Dynamic/Lua54/im-3.15-Lua54_Win64_dll17_lib.zip?viasf=1'
    # cd
    'https://master.dl.sourceforge.net/project/canvasdraw/5.14/Windows%20Libraries/Dynamic/cd-5.14_Win64_dll17_lib.zip?viasf=1'
    # cd lua bindings
    'https://master.dl.sourceforge.net/project/canvasdraw/5.14/Windows%20Libraries/Dynamic/Lua54/cd-5.14-Lua54_Win64_dll17_lib.zip?viasf=1'
    # iup
    'https://master.dl.sourceforge.net/project/iup/3.32/Windows%20Libraries/Dynamic/iup-3.32_Win64_dll17_lib.zip?viasf=1'
    # iup lua bindings
    'https://master.dl.sourceforge.net/project/iup/3.32/Windows%20Libraries/Dynamic/Lua54/iup-3.32-Lua54_Win64_dll17_lib.zip?viasf=1'
    # lua
    'https://master.dl.sourceforge.net/project/luabinaries/5.4.2/Windows%20Libraries/Dynamic/lua-5.4.2_Win64_dll17_lib.zip?viasf=1'

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
    e7a99e6b9a93ac3b8e9c8dc7c00930a98e25d893  # im-3.15_Win64_vc17_lib.zip
    08fdadc7c70f47058f2116f14881dbac2b76af54  # im-3.15-Lua54_Win64_vc17_lib.zip
    f4279c60aebbe742708f13a182a09f3c74518098  # cd-5.14_Win64_vc17_lib.zip
    8d17c227ce6dec3522f49b21664ea0f51f2b12c3  # cd-5.14-Lua54_Win64_vc17_lib.zip
    98d711bfed73f3cebf83c04685a24474b18cae0a  # iup-3.32_Win64_vc17_lib.zip
    6176df552bd0c1731131ae8cc27d65315bf29de4  # iup-3.32-Lua54_Win64_vc17_lib.zip
    0bedf037dc92399b1651b0acf492ab959ebcbd9c  # lua-5.4.2_Win64_vc17_lib.zip
    e0cb0efd80242dc6c0194657094c900624dd185d  # im-3.15_Win64_dll17_lib.zip
    9074c258b25bf280e123b99aba558ec6a574368a  # im-3.15-Lua54_Win64_dll17_lib.zip
    df468cc97aaae8150ae70a46ea1c1c870bbcd786  # cd-5.14_Win64_dll17_lib.zip
    7c9b9934dcdabbb96a9bbc531c5dd7a3cc07eed3  # cd-5.14-Lua54_Win64_dll17_lib.zip
    daa4e6ef71651bbd55171f9f891c42751a4e2454  # iup-3.32_Win64_dll17_lib.zip
    eaa96af341afae70c59da151631edb6b4a730b2e  # iup-3.32-Lua54_Win64_dll17_lib.zip
    bc62d30c0e5e7c95d3af729f2668e5632df78697  # lua-5.4.2_Win64_dll17_lib.zip
    e14f2df0f80c13f88e3d699c67c7cb03f80e7cd4  # iup-3.32_Win64_bin.zip
    e827ebdd776509bce43cc850fedc18000bcc2672  # iup-3.32-Lua54_Win64_bin.zip
    61ac23a2ed72a6bfe8f23727d8ec4954fab70f20  # iup-3.32_Docs_html.zip
    f1a88e93dc35c837c1f144b0b37f0cf64d403ffb  # iup-3.32.chm
    f4b08ff78244d46e018c30d5bd737354e92d0a95  # iup-3.32.pdf
)

PKG_ROOT=iup-build

filename() {
    local url=$1
    basename "$url" | sed -Ee 's,^([^?]+).*,\1,'
}

download() {
    for url in "${iup_urls[@]}"; do
        #echo url "$url"
        local fname
        fname=$(filename "$url")

        local local_sz=
        if [[ -f $fname ]]; then
            local_sz=$(wc -c "$fname" | awk '{print $1}')
        fi
        echo fname "$fname" sz "$local_sz"

        local out rc sz
        out=$(curl --silent --show-error --head --write-out '%{http_code}' "$url" | tr -d '\r')
        rc=$(tail -1 <<<"$out")
        [[ "$rc" == 200 ]] || { echo "head request failed with code $rc: $url" 1>&2 ; exit 1; }
        sz=$(sed -nEe 's/content-length: ([0-9]+)/\1/ip' <<<"$out")
        #echo remote sz "$sz"

        if (( sz != local_sz )); then
            echo =========================== download "$fname"
            rc=$(curl --silent --show-error --write-out '%{http_code}' -L -o "$fname" "$url")
            [[ $rc == 200 ]] || { echo "download failed with code $rc: $url" 1>&2 ; exit 1; }
        fi

    done
}

checkpkgs() {
    for ((i = 0; i < ${#iup_urls[@]}; ++i)); do
        local url=${iup_urls[$i]}
        local sha1_exp=${iup_sha1sums[$i]}
        local fname sha1
        fname=$(filename "$url")
        sha1=$(sha1sum "$fname" | awk '{print $1}')
        #echo sha1 exp $sha1_exp got $sha1
        [[ "$sha1_exp" == "$sha1" ]] || { echo "unexpected sha1 sum for $fname" 1>&2 ; exit 1; }
    done

}

pkgpath() {
    local fname=$1
    local base

    case "$fname" in
        *_dll17_lib*)
            base="$PKG_ROOT/lib/dll"
            ;;

        *_vc17_lib*)
            base="$PKG_ROOT/lib/static"
            ;;
        *_bin.*)
            base="$PKG_ROOT/bin"
            ;;
        *iup-*_Docs_html.zip|iup-*.chm|iup-*.pdf)
            base="$PKG_ROOT/doc"
            ;;
        *)
            echo "don't know pkg path for $fname" 1>&2
            exit 1;
    esac

    # module should be equal to iup, im, cd or lua
    local module=${fname%%-*}

    if [[ $fname =~ (Lua[[:digit:]]+) ]]; then
        local lua=${BASH_REMATCH[1]}
        echo "$base/$module/$lua"
    else
        if [[ $fname =~ _Docs_html\.zip ]]; then
            # zip contents path already starts with module name: iup/html/...
            echo "$base"
        else
            echo "$base/$module"
        fi
    fi
}

moveincludes() {
    local path=$1

    echo moveincludes path "$path" 1>&2

    if [[ -d $path/include ]]; then
        local incpath
        incpath=$(sed -Ee 's,/lib/(static|dll)/,/include/,' <<<"$path")
        mv "$path"/include/* "$incpath"
        rmdir "$path/include"
    fi
}

copydoc() {
    local fname=$1
    local path=$2

    if [[ $fname =~ '.chm'$ || $fname =~ '.pdf'$ ]]; then
        echo ======================= copydoc fname "$fname" path "$path" 1>&2
        cp "$fname" "$path"
    fi

}

unpack() {
    mkdir -p "$PKG_ROOT"/{lib/static,lib/dll,include}/{cd,im,iup,lua}
    mkdir -p "$PKG_ROOT"/lib/{static,dll}/{cd,im,iup}/Lua54
    mkdir -p "$PKG_ROOT"/bin/iup/Lua54
    mkdir -p "$PKG_ROOT"/doc/iup


    for url in "${iup_urls[@]}"; do
        local fname path
        fname=$(filename "$url")
        path=$(pkgpath "$fname")
        echo "$fname" "$path"
        [[ -d $path ]]

        [[ $fname =~ ".zip"$ ]] && unzip -x "$fname" -d "$path"

        moveincludes "$path"
        copydoc "$fname" "$path"
    done
}


mkdir -p build/vc17
cd build/vc17
download
checkpkgs
unpack
