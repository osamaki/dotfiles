# dotfilesへのリンクをホームに貼る

cur_dir=$(pwd)

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
	if [[ -e ~/"$f" ]]
	then
		echo ~/"$f" already exist
		continue
	fi
    ln -s "$cur_dir"/"$f" ~/"$f"
	echo linked "$cur_dir"/"$f" to ~/"$f" successfully
done
