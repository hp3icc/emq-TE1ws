# emq-TE1ws
Bash Proyecto Todo en uno , auto instalable MMDVMHost ,Direwolf , Multimon-ng , Ionosphere , Dvswitch, YSFReflector , YSF2DMR , HBLink3 , Dashboard Websock

Dashboard html sobre websock , soporte GPSD , CM108 .

Ultima revision: emq-TE1ws-Rev9b 12/07/2021 
#

TE1ws , mantiene las mismas aplicaciones de uso para radio aficionados de sus versiones anteriores y un poco mas en cada nueva actualizacion .

Listado de aplicaciones de radioaficionados, que incluye la imagen y bash de instalación :

Direwolf 

Muntimon-NG 

Ionosphere

MMDVMHost

pYSFReflector 

YSF2DMR

Dvswitch 

HBLink3


Esta versión cuenta con Dashboard HTML corriendo sobre websock , para el MMDVMHost y Reflector YSF , estan preconfigurados a puerto http 80 , pero desde el menú puede cambiar al puerto 8000, 8080 , o cualquier otro de su preferencia .

se agrega Librerias y aplicacion de gps y GPSD

Se agrega lista mundial de nombres de TG de la red DMR brandmeister .

Se agrega listado de nombres de salas del Proyecto Treehouse EUROPELINK según el DG-ID correspondiente .


Compatible con Raspberry pi : zero , P2 , P3 y P4

#

Puede descargara y utilizar el bash de instalacion con el siguiente comando :

wget https://github.com/hp3icc/emq-TE1ws/raw/main/emq-TE1ws-Rev9.sh

sh TE1ws-Rev9.sh

al finalizar la instalacion el equipo se reiniciara y podra accesar via ssh o por consola a la lista de aplicaciones escribiendo ( menu ) en su consola.

#

Puede instalar descargando la imagen ya compilada para Raspberry . 

https://drive.google.com/file/d/1NM2a17NngY34Tb4GO6Ww0BstTRD8sjWe/view?usp=sharing

https://mega.nz/file/EVVwyZYL#tJlm6PvLX2xMIs3Jt8aep9itj3rpKbyuHE8D0deiJBI

Usuario :    pi

Contraseña:  Panama507


#
CONEXION WIFI 

Si su equipo cuenta con dispositivo de red inalambrica (WIFI) o es modelo Raspberry Zero W , despues de haber grabado la imagen en la memoria micro sd con la herramienta rufus , balena o otra aplicacion , en la particion creada en la micro sd con el nombre boot , debe crear un archivo con el nombre:  
wpa_supplicant.conf

Dentro de este archivo ,debe incuir los nombres de redes wifi y contraseñas de cada una, a las que desea su raspberry se conecte , puede agregar una o cuantas redes wifi tenga , para que su equipo se conecte .

Tomar de referencia el archivo de ejemplo :

https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/wpa_supplicant.conf

#
Exitos en sus proyectos con raspberry 

HP3ICC

Esteban Mackay Q.

73.

#

# emq-TE1ws
All-in-one project bash, self-installable MMDVMHost, Direwolf, Multimon-ng, Ionosphere, Dvswitch, YSFReflector, YSF2DMR, HBLink3, Dashboard Websock

Html dashboard over websock, GPSD support, CM108.

Last revision: emq-TE1ws-Rev9b 12/07/2021
#

TE1ws, maintains the same applications for use for amateur radio of its previous versions and a little more in each new update.

List of amateur radio applications, including image and installation attempt:

Direwolf

Muntimon-NG

Ionosphere

MMDVMHost

pYSFReflector

YSF2DMR

Dvswitch

HBLink3


This version has HTML Dashboard running on websock, for the MMDVMHost and YSF Reflector, they are preconfigured to http port 80, but from the menu you can change to port 8000, 8080, or any other of your preference.

Libraries and gps and GPSD application is added

Added worldwide list of TG names from DMR brandmeister network.

A list of room names of the Treehouse EUROPELINK Project is added according to the corresponding DG-ID.


Raspberry pi compatible: zero, P2, P3 and P4

#

You can download and use the install bash with the following command:

wget https://github.com/hp3icc/emq-TE1ws/raw/main/emq-TE1ws-Rev9.sh

sh TE1ws-Rev9.sh

At the end of the installation the computer will restart and you will be able to access via ssh or by console to the list of applications by typing (menu) in your console.

#

You can install by downloading the already compiled image for Raspberry.

https://drive.google.com/file/d/1NM2a17NngY34Tb4GO6Ww0BstTRD8sjWe/view?usp=sharing

https://mega.nz/file/EVVwyZYL#tJlm6PvLX2xMIs3Jt8aep9itj3rpKbyuHE8D0deiJBI


User: pi

Password: Panama507

#
WIFI CONNECTION

If your equipment has a wireless network device (WIFI) or is a Raspberry Zero W model, after having recorded the image in the micro sd memory with the rufus tool, balena or another application, in the partition created in the micro sd with the name boot, you should create a file with the name:
wpa_supplicant.conf

Within this file, you must include the names of Wi-Fi networks and passwords of each one, to which you want your raspberry to connect, you can add one or how many Wi-Fi networks you have, so that your equipment connects.

Take the example file as a reference:

https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/wpa_supplicant.conf

#
Successes in your projects with raspberry

HP3ICC

Esteban Mackay Q.

73.

#
