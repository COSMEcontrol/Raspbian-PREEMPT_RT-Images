#!/bin/bash
#####################################################
#### Alberto Azuara
#### Versión 1.0
#### 12/01/15
#### Descarga y copia imagen de Raspbian-RT del repositorio
#####################################################

URL_IMAGE_PART1="https://github.com/COSMEcontrol/RaspbianRT-Images/releases/download/3.12.31/Raspbian_3.12.31_PREEMPT_RT.img.7z.001"
URL_IMAGE_PART2="https://github.com/COSMEcontrol/RaspbianRT-Images/releases/download/3.12.31/Raspbian_3.12.31_PREEMPT_RT.img.7z.002"
URL_IMAGE_PART3="https://github.com/COSMEcontrol/RaspbianRT-Images/releases/download/3.12.31/Raspbian_3.12.31_PREEMPT_RT.img.7z.003"
URL_IMAGE_PART4="https://github.com/COSMEcontrol/RaspbianRT-Images/releases/download/3.12.31/Raspbian_3.12.31_PREEMPT_RT.img.7z.004"
ruta_sd=""

#comprobar si soy root
if [[ $EUID -ne 0 ]]; then
	echo -n "[Error] Este script debe ser ejecutado por el usuario root. "
	exit 1
fi

echo "[*] Comprobando utilidades de compilacion... "
type 7z > /dev/null 2>&1 || { echo >&2 "[!] Instalar \"descompresor 7z (apt-get install p7zip-full)\""; read -p "Press [Enter] to continue..."; exit 1; }


while [ -f $ruta_sd ]
do
	echo "[*] Intruduce la ruta completa del lector de tarjetas SD (/dev/mmcblk0)"
	read ruta_sd
done

mkdir downloads/
cd downloads/
echo "[*] Descargando todas las partes de la imagen de Raspbian-RT del repositorio... "
wget $URL_IMAGE_PART1
wget $URL_IMAGE_PART2
wget $URL_IMAGE_PART3
wget $URL_IMAGE_PART4
echo "ok! "

echo -n "[*] Descomprimiendo y uniendo las partes de la imagen de Raspbian-RT... "
7z x Raspbian_3.12.31_PREEMPT_RT.img.7z.001
echo "ok! "

echo -n "[*] Copiando la imagen a la tarjeta SD... "
dd if=Raspbian_3.12.31_PREEMPT_RT.img  of=$ruta_sd
echo "ok! "

echo -n "[*] Eliminando elementos innecesarios..."
rm Raspbian_3.12.31_PREEMPT_RT.img.7z.001
rm Raspbian_3.12.31_PREEMPT_RT.img.7z.002
rm Raspbian_3.12.31_PREEMPT_RT.img.7z.003
rm Raspbian_3.12.31_PREEMPT_RT.img.7z.004
rm Raspbian_3.12.31_PREEMPT_RT.img
cd ..
echo "ok! "
echo "[*] Listo!"

exit 0
