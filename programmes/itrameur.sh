
#!/usr/bin/env bash


if [[ $# -ne 2 ]]
then
	echo "Deux arguments attendus: <dossier> <langue>"
	exit
fi

dossier=$1 #dossier dumps-text OU contextes (dépend du dossier donné en argument)
basename=$2 #en, fr, ch

echo "<lang=\"$basename\">" > "./itrameur/$dossier-$basename.txt"

for chemin in $(ls $dossier/$basename-*.txt)
do
	#chemin : dumps-texts/en-1.txt
	fichier=$(basename -s .txt $chemin)
	#fichier : en-1


	echo "<page=\"$fichier\">" >> "./itrameur/$dossier-$basename.txt"
	echo "<text>" >> "./itrameur/$dossier-$basename.txt"
	
	content=$(cat $chemin)

	content=$(echo "$content" | sed 's/&/&amp;/g')
	content=$(echo "$content" | sed 's/</&lt;/g')
	content=$(echo "$content" | sed 's/>/&gt;/g')

	echo "$content" >> "./itrameur/$dossier-$basename.txt"

	echo "</text>" >> "./itrameur/$dossier-$basename.txt"
	echo "</page> §" >> "./itrameur/$dossier-$basename.txt"
done

echo "</lang>" >> "./itrameur/$dossier-$basename.txt"
