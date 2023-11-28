#!/usr/bin/env bash

if [[ $# -ne 1 ]];
then
	echo "On veut exactement un argument au script."
	exit
fi

URLS=$1

if [ ! -f $URLS ]
then
	echo "On attend un fichier, pas un dossier"
	exit
fi

echo "<html>
	<head>
		<meta charset=\"UTF-8\">
	</head>
	<body>"

echo "	<table>
		<tr><th>ligne</th><th>URL</th><th>code HTTP</th><th>encodage</th><th>compte</th><th>dump-html</th><th>dump-txt</th><th>contexte</th></tr>"

lineno=1
while read -r URL
do
	lang=$(basename $URLS .txt)
	response=$(curl -s -I -L -w "%{http_code}" -o /dev/null $URL)
	#URL 2, 21, 37, 50 code 403
	dump_html=$(curl $URL > "../aspirations/${lang}-${lineno}.html")
	dump_text=$(lynx -dump -assume_charset=utf-8 --display_charset=utf-8 $URL > "../dumps-text/${lang}-${lineno}.txt")
	encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | ggrep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
	compte=$(cat ../dumps-text/${lang}-${lineno}.txt | egrep -o "责任" -c)
	contexte=$(cat ../dumps-text/${lang}-${lineno}.txt | egrep -A 2 -B 2 "责任" > "../contextes/${lang}-${lineno}.txt")
	#-A NUM pour grep lignes d'après et -B NUM pour lignes d'avant
	echo -e "<tr>
            <td>$lineno</td>
            <td>$URL</td>
            <td>$response</td>
            <td>$encoding</td>
            <td>$compte</td>
            <td><a href=../aspirations/${lang}-${lineno}.html>html</a></td>
            <td><a href=../dumps-text/${lang}-${lineno}.txt>txt</a></td>
            <td><a href=../contextes/${lang}-${lineno}.txt>contextes</a></td>
        </tr>"
	lineno=$(expr $lineno + 1)
done < "$URLS"

echo "	     </table>
	</body>
</html>"
