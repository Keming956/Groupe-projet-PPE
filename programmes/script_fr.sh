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

CIBLE="devoirs?"


echo "<html>
	<head>
		<meta charset=\"UTF-8\">
		<link rel=\"stylesheet\" type=\"text/css\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css\">
        <script src=\"https://code.jquery.com/jquery-3.3.1.slim.min.js\"></script>
        <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js\"></script>
        <script src=\"https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js\"></script>
	</head>
	<body>
	<table class=\"table table-striped table-hover\">
		<thead>
		<tr>
			<th scope=\"col\">ligne</th>
			<th scope=\"col\">URL</th>
			<th scope=\"col\">code HTTP</th>
			<th scope=\"col\">encodage</th>
			<th scope=\"col\">compte</th>
			<th scope=\"col\">dump-html</th>
			<th scope=\"col\">dump-txt</th>
			<th scope=\"col\">contexte</th>
			<th scope=\"col\">condordanciers</th>
		</tr>
		</thead>
		<tbody>
		" > ../tableaux/frrr.html

lineno=0
while read -r URL
do
    lineno=$(expr $lineno + 1)
	lang=$(basename $URLS .txt)
	response=$(curl -s -I -L -w "%{http_code}" -o /dev/null $URL)
	dump_html=$(curl $URL > "../aspirations/${lang}-${lineno}.html")
	encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1 | tr '[:lower:]' '[:upper:]')
	concordance_table=$(echo -e "<html><table><tr><th>contexte gauche</th><th>CIBLE</th><th>contexte droit</th></tr></table></html>" > "../concordances/${lang}-${lineno}.html")


	COUNT=0
	if [ $response -eq 200 ]
	then

		if [ ! $encoding == "UTF-8" ]
			then iconv -f "$encoding" -t "UTF-8" -o "/tmp/recode_${lineno}.html" "../aspirations/${lang}-${lineno}.html"
			mv "/tmp/recode_${lineno}.html" "../aspirations/${lang}-${lineno}.html"
		fi
		lynx -assume_charset UTF-8 -dump -nolist ../aspirations/${lang}-${lineno}.html > ../dumps-text/${lang}-${lineno}.txt
		cellule_html="<a href=../aspirations/${lang}-${lineno}.html>html</a>"
		cellule_text="<a href=../dumps-text/${lang}-${lineno}.txt>txt</a>"
        compte=$(cat ../dumps-text/${lang}-${lineno}.txt | egrep -i -o "$CIBLE" | wc -l) >> ../tableaux/frrr.html
        contexte=$(cat ../dumps-text/${lang}-${lineno}.txt | egrep -i -A 2 -B 2 "$CIBLE" > "../contextes/${lang}-${lineno}.txt")
        cellule_contextes="<a href="../contextes/${lang}-${lineno}.txt">"contextes"</a>"


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

		grep -E -T -i "(\w+\W+){0,5}\b$CIBLE\b(\W+\w+){0,5}" ../contextes/${lang}-$lineno.txt | sed -E 's/(.*)([dD]evoirs?|DEVOIRS?)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/' >>"../concordances/${lang}-$lineno.html"
																																	

		cellule_concord="<a href=../concordances/${lang}-$lineno.html>tableau</a>"

		    echo "
                </table>
            </body>
        </html>
        " >> ../concordances/${lang}-$lineno.html



	elif [ ! $response == "200" ]
	then

		cellule_text="indisponible"
		cellule_contextes="indisponible"
		cellule_concord="indisponible"
		compte="indisponible"
		cellule_html="indisponible"

    fi

echo -e "<tr>
            <th scope=\"row\">$lineno</th>
            <td>$URL</td>
            <td>$response</td>
            <td>$encoding</td>
            <td>$compte</td>
            <td>$cellule_html</td>
            <td>$cellule_text</td>
            <td>$cellule_contextes</td>
            <td>$cellule_concord</td>
        </tr>
		" >> ../tableaux/frrr.html


done < "$URLS"

echo "
</tbody>
</table>
</body>
</html> " >> ../tableaux/frrr.html
