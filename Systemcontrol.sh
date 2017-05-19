#!/bin/bash
echo "----------SYSTEME DE CONTROLE ----------------------"

#================================================
# F O N C T I O N S . . .
#================================================
#------------------------------------------------
# Menu - Affichage d'un menu
#------------------------------------------------
# Args : $1    = Titre du menu
#        $2n   = Fonction associée 'n' au choix
#        $2n+1 = Libellé du choix 'n' du menu
#------------------------------------------------
Menu()
{
  local -a menu fonc
  local titre nbchoix
  # Constitution du menu
  if [[ $(( $# % 1 )) -ne 0 ]] ; then
     echo "$0 - Menu indisponible" >&2
     return 1
  fi
  titre="$1"
  shift 1
  set "$@" "return 0" "Sortie"
  while [[ $# -gt 0 ]]
  do
     (( nbchoix += 1 ))
     fonc[$nbchoix]="$1"
     menu[$nbchoix]="$2"
     shift 2
  done
  # Affichage menu
  PS3="Votre choix ? "
  while :
  do
     echo
     [[ -n "$titre" ]] && echo -e "$titre\n"
     select choix in "${menu[@]}"
     do
        if [[ -z "$choix" ]]
           then echo -e "\nChoix indisponible"
           else eval ${fonc[$REPLY]}
        fi
        break
     done || break
  done
}
#------------------------------------------------
# CHome - Création fichier home.tar.gz
#------------------------------------------------
CHome()
{
   echo -e "\n***\n*** CHome\n***\n"
	echo "Bienvenu chez nous"
}
#------------------------------------------------
# CEtcRoot -la fonction qui peret l'aquisition installation
#------------------------------------------------
CEtcRoot()
{
   echo -e "\n***\n*** CEtcRoot\n***\n"
   sudo dpkg --configure -a 
   sudo apt-get install xamp
   sudo /xamp/xamp start
}
#------------------------------------------------
# fonction qui affiche l'information sur l'utilisateur enregistre
#------------------------------------------------
GHome()
{
   echo -e "\n***\n*** GHome\n***\n"
}
#------------------------------------------------
# GEtcRoot - information sur l'utilisateur du disque de la memoire du process
#------------------------------------------------
GEtcRoot()
{
   echo -e "\n***\n*** -----Information sur l'utilisateur du disque -----\n***\n"
    df -h ; top
}
#================================================
# M A I N . . .
#================================================
Menu \
  "+++ Bienvenu sur mon projet Syst +++"                           \
  CHome    "Information sur l'utilisateur enregisteré il y a trois jours"          \
  CEtcRoot "Acqusititon installation et lancement de l'environnement xamp" \
  GHome    "Archivage des elements du repertoire personnel qui ont ete modifier pour l'utilisateur sudoer il ya deux jour dans un periferique externe"             \
  GEtcRoot "Information sur l'utilisateur du disque de la memoire du processuer et de la swap"
