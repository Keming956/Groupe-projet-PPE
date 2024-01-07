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

CIBLE="责任"

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
		" > ../tableaux/ch.html

lineno=0
while read -r URL
do
    lineno=$(expr $lineno + 1)
	lang=$(basename $URLS .txt)
	response=$(curl -s -I -L -w "%{http_code}" -o /dev/null $URL)
	#URL 2, 21, 37, 50 code 403
	dump_html=$(curl $URL > "../aspirations/${lang}-${lineno}.html")
	encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | ggrep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
	concordance_table=$(echo -e "<html><table><tr><th>contexte gauche</th><th>CIBLE</th><th>contexte droit</th></tr></table></html>" > "../concordances/${lang}-${lineno}.html")


	COUNT=0
	TEXTFILE="RIEN"
	if [ $response == "200" ]
	then
		w3m $URL > ../dumps-text/${lang}-${lineno}.txt
        TEXTFILE="../dumps-text/${lang}-${lineno}.txt"
        python -m thulac ${TEXTFILE} ../dumps-text/${lang}-${lineno}_token.txt -seg_only
        TEXTFILE=../dumps-text/${lang}-${lineno}_token.txt
        compte=$(cat ../dumps-text/${lang}-${lineno}.txt | egrep -o "$CIBLE" -c) >> ../tableaux/ch.html
        contexte=$(cat ../dumps-text/${lang}-${lineno}_token.txt | egrep -i -A 2 -B 2 "$CIBLE" > "../contextes/${lang}-${lineno}.txt")
        	#-A NUM pour grep lignes d'après et -B NUM pour lignes d'avant


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

		ggrep -E -T -i "$CIBLE" ../contextes/${lang}-$lineno.txt | sed -E "s/(.*)($CIBLE)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> "../concordances/${lang}-$lineno.html"

		    echo "
                </table>
            </body>
        </html>
        " >> ../concordances/${lang}-$lineno.html


		CONCORD="../concordances/${lang}-${lineno}.html"
    fi

echo -e "<tr>
            <th scope=\"row\">$lineno</th>
            <td>$URL</td>
            <td>$response</td>
            <td>$encoding</td>
            <td>$compte</td>
            <td><a href=../aspirations/${lang}-${lineno}.html>html</a></td>
            <td><a href=$TEXTFILE>txt</a></td>
            <td><a href=../contextes/${lang}-${lineno}.txt>contextes</a></td>
            <td><a href=$CONCORD>tableau</a></td>
        </tr>
		" >> ../tableaux/ch.html


done < "$URLS"

echo "	    
</tbody>
</table>
</body>
</html> " >> ../tableaux/ch.html
