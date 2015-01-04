#!/bin/bash
#####################################################
#### Alberto Azuara
#### Versión 1.0
#### 04/01/15
#### Descarga y copia imagen de Raspbian-RT del repositorio
#####################################################

URL_IMAGE="http://downloads.raspberrypi.org/raspbian/images/raspbian-2014-09-12/2014-09-09-wheezy-raspbian.zip"
ruta_sd=""

#comprobar si soy root
if [[ $EUID -ne 0 ]]; then
	echo -n "[Error] Este script debe ser ejecutado por el usuario root. "
	exit 1
fi

while [ -f $ruta_sd ]
do
	echo -e "[*] Intruduce la ruta completa del lector de tarjetas SD (/dev/mmcblk0)"
	read ruta_sd
done
echo -n "[*] Descargando la imagen de Raspbian-RT del repositorio... "
wget $URL_IMAGE
echo "ok! "

echo -n "[*] Descomprimiendo la imagen de Raspbian-RT... "
unzip 2014-09-09-wheezy-raspbian.zip
echo "ok! "

echo -n "[*] Copiando la imagen a la tarjeta SD... "
dd if=2014-09-09-wheezy-raspbian.img  of=$ruta_sd
echo "ok! "

echo -n "[*] Eliminando elementos innecesarios..."
rm 2014-09-09-wheezy-raspbian.zip
rm 2014-09-09-wheezy-raspbian.img
echo "ok! "
echo "[*] Listo!"

exit 0
