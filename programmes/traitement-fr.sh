#!/usr/bin/env bash

if [[ $# -ne 1 ]];
then
	echo "On veut exactement un argument au script."
	exit
fi

URLS=$1

ancien_mot="\([dD]evoirs\?\)\|\(DEVOIRS\?\)"
nouveau_mot="devoir"


# Remplacer "ancien_mot" par "nouveau_mot" dans le fichier texte.txt
sed -i "s/${ancien_mot}/${nouveau_mot}/g" $URLS
