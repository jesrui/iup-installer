#!/bin/bash
# Download zip files for iup 3.30 and dependencies from sourceforge
# and unpack them into a single dir tree.
#
# Included are static libs and dlls compiled for win32 x64 with vs16,
# headers, Lua 5.4 bindings, examples and documentation.
#
#set -euxo pipefail
set -euo pipefail

iup_urls=(
	# static libs compiled for win32 x64 with vs16, lua 5.4 bindings and their headers
	# im
	https://netcologne.dl.sourceforge.net/project/imtoolkit/3.15/Windows%20Libraries/Static/im-3.15_Win64_vc16_lib.zip
	# im lua bindings
	https://versaweb.dl.sourceforge.net/project/imtoolkit/3.15/Windows%20Libraries/Static/Lua54/im-3.15-Lua54_Win64_vc16_lib.zip
	# cd
	https://altushost-swe.dl.sourceforge.net/project/canvasdraw/5.14/Windows%20Libraries/Static/cd-5.14_Win64_vc16_lib.zip
	# cd lua bindings
	'https://master.dl.sourceforge.net/project/canvasdraw/5.14/Windows%20Libraries/Static/Lua54/cd-5.14-Lua54_Win64_vc16_lib.zip?viasf=1'
	# iup
	https://netcologne.dl.sourceforge.net/project/iup/3.30/Windows%20Libraries/Static/iup-3.30_Win64_vc16_lib.zip
	# iup lua bindings
	https://netcologne.dl.sourceforge.net/project/iup/3.30/Windows%20Libraries/Static/Lua54/iup-3.30-Lua54_Win64_vc16_lib.zip
	# lua
	https://versaweb.dl.sourceforge.net/project/luabinaries/5.4.0/Windows%20Libraries/Static/lua-5.4.0_Win64_vc16_lib.zip

	# dlls compiled for win32 x64 with vs16, lua 5.4 bindings and their headers and import libs
	# im
	'https://master.dl.sourceforge.net/project/imtoolkit/3.15/Windows%20Libraries/Dynamic/im-3.15_Win64_dll16_lib.zip?viasf=1'
	# im lua bindings
	'https://master.dl.sourceforge.net/project/imtoolkit/3.15/Windows%20Libraries/Dynamic/Lua54/im-3.15-Lua54_Win64_dll16_lib.zip?viasf=1'
	# cd
	https://netcologne.dl.sourceforge.net/project/canvasdraw/5.14/Windows%20Libraries/Dynamic/cd-5.14_Win64_dll16_lib.zip
	# cd lua bindings
	'https://master.dl.sourceforge.net/project/canvasdraw/5.14/Windows%20Libraries/Dynamic/Lua54/cd-5.14-Lua54_Win64_dll16_lib.zip?viasf=1'
	# iup
	https://netix.dl.sourceforge.net/project/iup/3.30/Windows%20Libraries/Dynamic/iup-3.30_Win64_dll16_lib.zip
	# iup lua bindings
	'https://master.dl.sourceforge.net/project/iup/3.30/Windows%20Libraries/Dynamic/Lua54/iup-3.30-Lua54_Win64_dll16_lib.zip?viasf=1'
	# lua
	'https://master.dl.sourceforge.net/project/luabinaries/5.4.0/Windows%20Libraries/Dynamic/lua-5.4.0_Win64_dll16_lib.zip?viasf=1'

	# executables compiled for win32 x64 with vs16 & lua 5.4 bindings
	# iup
	https://netix.dl.sourceforge.net/project/iup/3.30/Tools%20Executables/iup-3.30_Win64_bin.zip
	# iup lua
	https://kumisystems.dl.sourceforge.net/project/iup/3.30/Tools%20Executables/Lua54/iup-3.30-Lua54_Win64_bin.zip

	# doc and examples
	# iup html
	'https://master.dl.sourceforge.net/project/iup/3.30/Docs%20and%20Sources/iup-3.30_Docs_html.zip?viasf=1'
	# iup chm
	'https://master.dl.sourceforge.net/project/iup/3.30/Docs%20and%20Sources/iup-3.30_Docs.chm?viasf=1'
	# iup pdf
	'https://netcologne.dl.sourceforge.net/project/iup/3.30/Docs%20and%20Sources/iup-3.30_Docs.pdf'

)

# in the same order as iup_urls
iup_sha1sums=(
	d302f5aa5324ba33825545a9586d9d5e19726ffe  # im-3.15_Win64_vc16_lib.zip
	bf42c708c58014df6297be6e8b900ce41cfb0643  # im-3.15-Lua54_Win64_vc16_lib.zip
	45041ffb27083c1b345c352580c3748723f54f1b  # cd-5.14_Win64_vc16_lib.zip
	257e966ba32264bea40d38e48d69618f0c699537  # cd-5.14-Lua54_Win64_vc16_lib.zip
	ef131e2b8a15acde8a190e7b47b7e9b866982da4  # iup-3.30_Win64_vc16_lib.zip
	6fb9c42cb0de90a8b9e68245ae92fa241abe51e2  # iup-3.30-Lua54_Win64_vc16_lib.zip
	90eb4475c264a2ed7166b29ec7663c13178ab622  # lua-5.4.0_Win64_vc16_lib.zip
	42a4dd8cd9d56615134b727e3cc6331f469fd30f  # im-3.15_Win64_dll16_lib.zip
	7c47d91163f49e139dcbf937bc21f288f4663470  # im-3.15-Lua54_Win64_dll16_lib.zip
	6b54d9abc4b938a637e6e300da7defc144ee8869  # cd-5.14_Win64_dll16_lib.zip
	3a426a54991f412c68ec3ca16b9e83a6e7cedddf  # cd-5.14-Lua54_Win64_dll16_lib.zip
	1483b021f57ffb63e7d2336dbce81af979da288c  # iup-3.30_Win64_dll16_lib.zip
	49b3d818d7612c188f0d7a3038569730978ee50d  # iup-3.30-Lua54_Win64_dll16_lib.zip
	220b4b8d3a37ac98852f681ca09bc1e5cb83bd65  # lua-5.4.0_Win64_dll16_lib.zip
	6d56117414b651a029087f1d443fbf0c161fbd2e  # iup-3.30_Win64_bin.zip
	48c01bf447e7d2910199e3bbb53c187a7ede0420  # iup-3.30-Lua54_Win64_bin.zip
	a02ff5efae8e5c68ac4a598216c49ff2a293ce3f  # iup-3.30_Docs_html.zip
	8fbf3bf32e589780e808c808c66e33ae76176836  # iup-3.30_Docs.chm
	38b57c1e406fd1ab09b1eb31a5b701eb37f02eb0  # iup-3.30_Docs.pdf
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
		[[ $rc == 200 ]] || { echo "head request failed with code $rc: $url" 1>&2 ; exit 1; }
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
		[[ $sha1_exp == "$sha1" ]] || { echo "unexpected sha1 sum for $fname" 1>&2 ; exit 1; }
	done

}

pkgpath() {
	local fname=$1
	local base

	case "$fname" in
		*_dll16*)
			base="$PKG_ROOT/lib/dll"
			;;

		*_vc16_lib*)
			base="$PKG_ROOT/lib/static"
			;;
		*_bin.*)
			base="$PKG_ROOT/bin"
			;;
		*_Docs*)
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
		if [[ $fname =~ '_Docs_html.' ]]; then
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


download
checkpkgs
unpack

