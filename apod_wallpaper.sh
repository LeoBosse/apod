#!/bin/bash

####
# Télécharge l'apod du jour si c'est une photo, l'enreistre et la définie comme fond d'écran à au premier allumage de l'ordinateur si il y a une connexion internet.
# Changer/créer le dossier "~/Pictures/Wallpapers" pour enregistrer les photos. Puis utiliser le bon nom ligne 1 et 13
# Enregistrer ce script dans ce nouveau dossier.
# Autoriser à executer ce script (terminal command: chmod +x <path>/apod_wallpaper.sh).
# Dans startup application (applications au démarrage), ajouter une application avec un nom du type apod_wallpaper, et la commande <path>/apod_wallpaper.sh en remplacant <path> par le chemin du fichier.
# Il marche sur ubuntu 18.04. il faut peut-être adapté les lignes 12 et 13 pour d'autres version (stack overflow est ton ami... ;))

cd ~/Pictures/Wallpapers

rm astropix.html* index.html* 2> /dev/null
#touch tmp

wget http://apod.nasa.gov/apod/astropix.html

image=`grep "IMG SRC" astropix.html | cut -d "\"" -f 2`
pic_name=`echo $image | cut -d "/" -f 3`
echo $image $pic_name
ls $pic_name 2>/dev/null
if [ -z `ls $pic_name 2>/dev/null` ]
then
    wget "http://apod.nasa.gov/apod/$image"
    export GIO_EXTRA_MODULES=/usr/lib/x86_64-linux-gnu/gio/modules/
    gsettings get org.gnome.desktop.background picture-uri
    gsettings set org.gnome.desktop.background picture-uri "file:///home/bossel/Pictures/Wallpapers/$pic_name"
fi

rm astropix.html* index.html* 2> /dev/null
