#!/bin/zsh

# dotfilesへのリンクをホームに貼る

cur_dir=$(pwd)

function link_recursively () {
	echo $1 "(basename: " $(basename $1) " )"
	base=$(basename $1)
	[[ "$base" == ".git" ]] && return
	[[ "$base" == ".DS_Store" ]] && return
	[[ "$base" == "view" ]] && return
	
	# 存在する場合
	if [[ -e ~/"$1" ]]
	then
		echo ~/"$1" already exist
		if [[ -d "$1" ]]
		then
			for f in $(ls "$1"/)
				link_recursively "$1"/"$f"
		fi
		continue
	else
		ln -s "$cur_dir"/"$1" ~/"$1"
		echo linked "$cur_dir"/"$1" to ~/"$1" successfully
	fi
}

# .から始まるファイルとディレクトリ
for f in .??*
do
	link_recursively "$f"
done
