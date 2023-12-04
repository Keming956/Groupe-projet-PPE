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

CIBLE="devoir(s)"

echo "<html>
	<head>
		<meta charset=\"UTF-8\">
	</head>
	<body>
	<table>
		<tr><th>ligne</th><th>URL</th><th>code HTTP</th><th>encodage</th><th>compte</th><th>dump-html</th><th>dump-txt</th><th>contexte</th><th>condordanciers</th></tr>" > ../tableaux/tableau-fr.html

lineno=0
while read -r URL
do
    lineno=$(expr $lineno + 1)
	lang=$(basename $URLS .txt)
	response=$(curl -s -I -L -w "%{http_code}" -o /dev/null $URL)
	#URL 2, 21, 37, 50 code 403
	dump_html=$(curl $URL > "../aspirations/${lang}-${lineno}.html")
	encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
	concordance_table=$(echo -e "<html><table><tr><th>contexte gauche</th><th>CIBLE</th><th>contexte droit</th></tr></table></html>" > "../concordances/${lang}-${lineno}.html")


	COUNT=0
	TEXTFILE="RIEN"
	if [ $response == "200" ]
	then
        lynx -dump -nolist ../aspirations/${lang}-${lineno}.html > ../dumps-text/${lang}-${lineno}.txt
        TEXTFILE="../dumps-text/${lang}-${lineno}.txt"
        compte=$(cat ../dumps-text/${lang}-${lineno}.txt | egrep -i -o "$CIBLE" | wc -l) >> ../tableaux/tableau-fr.html
        contexte=$(cat ../dumps-text/${lang}-${lineno}.txt | egrep -i -A 2 -B 2 "$CIBLE" > "../contextes/${lang}-${lineno}.txt")
        	#-A NUM pour grep lignes d'aprÃ¨s et -B NUM pour lignes d'avant


        echo "
        <html>
            <head>
              <meta charset=\"utf-8\">
	        </head>
		    <body>
			    <table>
				    <tr>
				        <th>contexte gauche</th>
					    <th>cible</th>
					    <th>contexte droit</th>
				    </tr>
	    " > ../concordances/${lang}-$lineno.html

		grep -E -T -i "(\w+\W+){0,5}\b$CIBLE\b(\W+\w+){0,5}" ../contextes/${lang}-$lineno.txt | sed -E "s/(.*)([dD]evoir(s))(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\4<\/td><\/tr>/">>"../concordances/${lang}-$lineno.html"

		    echo "
                </table>
            </body>
        </html>
        " >> ../concordances/${lang}-$lineno.html


		CONCORD="../concordances/${lang}-${lineno}.html"
    fi

	echo -e "<tr>
            <td>$lineno</td>
            <td>$URL</td>
            <td>$response</td>
            <td>$encoding</td>
            <td>$compte</td>
            <td><a href=../aspirations/${lang}-${lineno}.html>html</a></td>
            <td><a href=$TEXTFILE>txt</a></td>
            <td><a href=../contextes/${lang}-${lineno}.txt>contextes</a></td>
            <td><a href=$CONCORD>tableau</a></td>
        </tr>" >> ../tableaux/tableau-fr.html


done < "$URLS"

echo "	     </table>
	</body>
</html>"
>>../tableaux/tableau-fr.html