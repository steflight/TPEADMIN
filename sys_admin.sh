#!/bin/bash
	function showUsers(){
	   cat /etc/passwd | cut -d ":" -f1 > users.txt
	   cat users.txt | while read ligne
	 do
	   ls /home/ | grep $ligne > users.txt
	 done
	 echo "Liste des utilisateurs : "
	 while read ligne
	 do
	  echo "- $ligne"
	 done < users.txt
	}
	function archive(){
           read -p "veuillez entrer le chemin du périphérique externe : " path
	   user=$(cat /etc/group | grep sudo | cut -d ":" -f4)
	   sudo find /home/$user/* -ctime 2 > fichierstock.txt
	   mkdir archive
           cat fichierstock.txt | while read ligne
	 do
	   mv $ligne archive
	done
	  tar -cvs archive.tar archive/
	  gzip archive.tar	
	  cp archive.tar.gz $path
	}


question=1

while [ "$question" -eq 1 ];
do

 echo "*********************************             MENU   *************************************** *"
 echo "**********************************************************************************************"
 echo "                                                                                            "
 echo " a) Informations des utilisateurs enregistrés il y'a trois (03) jours                        "
 echo " b) Aquisition, Installation et Lancement de l'environnement XAMPP                          "
 echo " c) Archivage des éléments du repertoire personnel qui ont été modifier par l'utilisateur   " 
 echo "    sudoer il y'a deux jours dans le peripherique externe                                   "
 echo " d) Information sur l'utilisation du disque, de la mémoire, du processeur et du swap        "
 echo " q) Quitter (q) !                                                                           "


	echo -e "\n"
	echo -e "Veuillez choisir votre action: \c "
	read reponse

	case "$reponse" in 
		a) showUsers ;; 
		b)sudo /opt/lampp/lampp start 2> errtest ;
		  echo "XAMPP est deja installe";
			if [ $? -ne 0 ]; then
                		wget https://www.apachefriends.org/xampp-files/7.0.18/xampp-osx-7.0.18-0-installer.dmg;
				sudo chmod 755 xampp-linux-*-installer.run;
				sudo ./xampp-linux-*-installer.run;
				sudo /opt/lampp/lampp start 2> errtest;
			fi ;;
		
		c) archive;;
		
		d)vmstat ;;
		
		q) exit ;;
  	esac
     echo -e " Cliquer sur entrer pour continuer.... \c"
     read input

done		
