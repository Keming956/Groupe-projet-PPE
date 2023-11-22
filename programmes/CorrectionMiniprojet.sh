#!/usr/bin/env bash

##J'ai déjà fait ce script ici c'est la version corrigée du prof il y'a un probleme dans le chemin chemin à cause du dossier Travail Perso qui a un espace

if [ $# -ne 1 ]
then
    echo "On veut exactement un argument"
    exit
fi


URL=$1

if [ ! -f $URL ]         ##Est ce que le fichier existe ?
then
    echo "On attend un fichier, pas un dossier"
    exit
fi



lineno=1

while read -r line #/home/batou/Documents/TAL/Programmation_et_projets_encadres/Travail perso/PPE-2023/miniprojet/urls/fr.txt
do
    response=$(curl -s -I -L -w "%{http_code}" -o /dev/null $line)      ## -I affiche que les métadonnées de la page -s est le mode silencieux car sinon on a une barre de progression
    ## -w recuppère des informations spécifiques entre le serveur et mon ordi le dernier code http qu'il retrouve, -o /dev/null (on écrit vers un fichier poubelle // trou noir)
    ## -L si tu trouves des redirections tu les suis

    encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null $line | grep -P -o "charset=\S+" | cut -d"=" -f2)
    ##Pour recupp le charset
    ##curl -s -I -L -w "%{content_type}"
    ## on peut utiliser une expression régulière grep -P -o "charset=\S+" | cut -d"=" -f2 (on coupe avec le délimiteur = ), -f2 (le )eme champ)

    echo -e "$lineno\t$line\t$response\t$encoding" ##le echo -e permet de prendre en compte les caractères espacés
    lineno=$(expr $lineno + 1)
done<$URL



## si on veut utiliser grep pour être sûr d'avoir la dernière redirection il faut faire grep -P 'HTTP/' | tail -n 1 (permet de recupp le dernier code)
