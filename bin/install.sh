# dotfilesへのリンクをホームに貼る
for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
	if [[ -e ~/"$f" ]]
	then
		echo ~/"$f" already exist
		continue
	fi
    ln -s "$f" ~/"$f"
	echo linked "$f" to ~/"$f" successfully
done
