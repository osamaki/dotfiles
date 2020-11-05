# dotfilesへのリンクをホームに貼る

cur_dir=$(pwd)

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
	if [[ -e ~/"$f" ]]
	then
		echo unlinked ~/"$f" successfully
		unlink ~/"$f"
	else
		echo ~/"$f"" doesn't exist"
	fi
done
