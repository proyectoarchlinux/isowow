#!/bin/bash

clear

echo "    _________ ____     _       __    _       __";
echo "   /  _/ ___// __ \   | |     / /___| |     / /";
echo "   / / \__ \/ / / /   | | /| / / __ \ | /| / / ";
echo " _/ / ___/ / /_/ /    | |/ |/ / /_/ / |/ |/ /  ";
echo "/___//____/\____/     |__/|__/\____/|__/|__/   ";
echo "                                               ";
echo ""
echo "Asegúrese de tener su USB conectada..."
sleep 3
clear
echo -e ""
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' "_"
echo -e ""
echo -e "\t\t         Instalando Programas necesarios         "
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' _
echo -e ""
echo -e "Programas necesarios: dd - progress - dialog - zenity"
echo -e ""
echo -e ""
sleep 2
#pacman -Syy --noconfirm 
pacman -S db progress zenity dialog --noconfirm --needed
echo -e ""
echo -e ""
echo -e "Presiona ENTER para continuar"
echo -e ""
read line
clear

titulo="ISOwow - 0.1"

user=$(ls /home/)

while true; do
choice=$(dialog --keep-tite --backtitle "$titulo" --title "-| ISO Wow |-" \
--ok-label '*Seleccionar*' --nocancel --column-separator "|" --no-tags \
--menu "\nSeleccione una opción a continuación utilizando las teclas\n[FLECHA ARRIBA] / [FLECHA ABAJO] y [ESPACIO] o [ENTER]\
\nLas teclas alternativas también se pueden usar: [+], [-] y [TAB]. \n " 15 70 10 \
1 "Selecciona la ISO" \
2 "Selecciona la USB" \
3 "Grabar ISO" \
4 "Salir" 3>&1 1>&2 2>&3)

case "$choice" in
"1")
archivoISO=""
cmd=(dialog --keep-tite --no-collapse --cr-wrap --backtitle "$titulo" --column-separator "|" --no-tags --ok-label '< Seleccionar >' --nocancel --menu "Elige que medio para seleccionar la ISO" 9 50 9)

options=(1 "Seleccionar archivo ISO"
         2 "Escribir ruta del archivo ISO")

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

for choice in $choices
do
    case $choice in
1) 
archivoISO=$(sudo -u $user zenity  --title "Seleccione la ruta de la Imagen" --file-selection )
clear
;;

2)
archivoISO=$(dialog --stdout --title "Seleccione la ruta de la Imagen" --fselect "/home/${user}/" 20 80)
clear
;;
    esac
done
;;

"2")
disk=""
part="$(echo "print devices" | parted | grep /dev/ | awk '{if (NR!=1) {print}}')" 
disk=$(dialog --backtitle "$titulo" --clear --title "| Selección de USB |"  --ok-label 'Seleccionar' --no-cancel --menu "\nTenga mucho cuidado que dirección esta seleccionando\n> Puede dañar su sistema principal si elige mal" 10 60 0 ${part} 2>&1 >/dev/tty)
;;

"3")

clear
echo -e ""
echo -e ""
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' "_"
echo -e ""
echo -e "\t\t > Ruta de ISO: ${archivoISO}        "
echo -e ""
echo -e "\t\t > Ruta de USB: ${disk}        "
echo -e ""
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' _
echo -e ""
echo -e "Presiona ENTER para confirmar"
echo -e "Cierra la ventana para cancelar"
read line
clear

#echo "${archivoISO}"
#echo "${disk}"
clear
sudo sgdisk --zap-all ${disk}
sleep 2
clear

(echo o; echo n; echo p; echo 1; echo ""; echo ""; echo w; echo q) | fdisk ${disk}
sleep 2
clear

sudo fdisk -l ${disk}
sleep 2
clear

(echo s) | sudo mkfs.ext4 ${disk}1
#(echo s) | mkfs.ext4 -c ${disk}1
sleep 2
clear

printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' "_"
echo -e ""
echo -e " > ISO WoW 0.1"
echo -e ""
echo -e " > ${archivoISO}        "
echo -e ""
echo -e " > Grabando ISO en ${disk}1"
echo -e ""
echo -e " > Créditos: Daniel Nogales y Código Cristo"
echo -e ""
echo -e " > Cargando:"
#sudo dd if=${archivoISO} of=${disk}1 bs=1M oflag=dsync conv=notrunc,noerror & progress -mp $!
sudo dd if=${archivoISO} of=${disk}1 bs=1M oflag=dsync conv=notrunc,noerror status=progress
sync
echo -e ""
echo -e ""
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' "_"
echo -e ""
echo -e "\t\t > Repositorio: https://github.com/proyectoarchlinux/isowow"
echo -e ""
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' _
echo -e ""
echo -e "Presiona ENTER para Salir"
echo -e ""
read line
clear
exit

;;
"4")
exit
;;

    esac
done


