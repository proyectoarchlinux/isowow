#!/bin/bash
# Proyecto Archlinux
# Autor: Daniel Nogales
#
#
# Creación de un usb booteable

clear

function menu(){
  echo -e "Script creado por \e[92mDaniel Nogales\e[0m de \e[96mProyecto Archlinux\e[0m."
  echo ""
  printf "${BLUE}"
  figlet -c ISOWOW #echo -e "\e[36mISOWOW\e[0m"
  echo ""
  echo -e "\e[91m¡AVISO! Se formateará todo el contenido del USB o disco que selecciones, no me hago responsable del uso que le des al Script.\e[0m"
  echo ""
  echo "Escoja el disco a bootear:"
  echo ""
  echo "1) /dev/sdb"
  echo "2) /dev/sdc"
  echo "3) /dev/sdd"
  echo "4) /dev/sde"
  echo "5) /dev/sdf"
  echo ""
  echo "6) Escanear las unidades de discos"
  echo ""
  echo "7) Salir"
  echo ""
}

function error_reported(){
  if [ $iso = 1>&2 ];then
     echo ""
     echo -e "\e[91mERROR: Coloca la imagen iso en el directorio del Script (Solo 1)\e[0m"
     exit 0
  fi
}

BLUE="\e[34m"
opt=0
iso=$(ls *.iso)
error_reported

until [ "$opt" -eq 7 ]
do
  case "$opt" in
    1)
      echo "error"
      sudo dd if="$iso" of=/dev/sdb
      echo ""
      clear
      echo ""
      echo -e "\e[92m¡Listo!\e[0m \e[96mUSB preparado\e[0m"
      echo ""
      menu
    ;;
    2)
      sudo dd if="$iso" of=/dev/sdc
      echo ""
      clear
      echo ""
      echo -e "\e[92m¡Listo!\e[0m \e[96mUSB preparado\e[0m"
      echo ""
      menu
    ;;
    3)
      sudo dd if="$iso" of=/dev/sdd
      echo ""
      clear
      echo ""
      echo -e "\e[92m¡Listo!\e[0m \e[96mUSB preparado\e[0m"
      echo ""
      menu
    ;;
    4)
      sudo dd if="$iso" of=/dev/sde
      echo ""
      clear
      echo ""
      echo -e "\e[92m¡Listo!\e[0m \e[96mUSB preparado\e[0m"
      echo ""
      menu
    ;;
    5)
      sudo dd if="$iso" of=/dev/sdf
      echo ""
      clear
      echo ""
      echo -e "\e[92m¡Listo!\e[0m \e[96mUSB preparado\e[0m"
      echo ""
      menu
    ;;
    6)
      echo ""
      sudo fdisk -l | grep "Disco"
      echo ""
      menu
    ;;
    *)
      clear
      menu
    ;;
  esac
  read opt
done
