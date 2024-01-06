#!/usr/bin/env bash

if [[ $# -ne 1 ]];
then
	echo "On veut exactement un argument au script."
	exit
fi

URLS=$1

ancien_mot="\(\(d\|D\)ut\(y\|ies\)\)\|\(DUT\(Y\|IES\)\)"
nouveau_mot="duty"


# Remplacer "ancien_mot" par "nouveau_mot" dans le fichier texte.txt
sed -i "s/${ancien_mot}/${nouveau_mot}/g" $URLS
