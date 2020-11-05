#!/bin/zsh

# dotfilesへのリンクをホームに貼る

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
	if [[ -e ~/"$f" ]]
	then
		unlink ~/"$f"
		echo unlinked ~/"$f" successfully
	else
		echo ~/"$f"" doesn't exist"
	fi
done
