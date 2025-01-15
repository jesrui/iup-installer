# Do not execute this script directly, see install-iup-vc17.sh and install-iup-mingw6.sh

PKG_ROOT=iup-build

test -v CC || exit 1
test -v DLL || exit 1

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
        *_${DLL}_lib*)
            base="$PKG_ROOT/lib/dll"
            ;;
        *_${CC}_lib*)
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

mkdir -p "build/$CC"
cd "build/$CC"
download
checkpkgs
unpack
