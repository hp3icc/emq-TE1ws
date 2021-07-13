# emq-TE1ws
hp3icc Proyecto Todo en uno , MMDVMHost ,Direwolf , Multimon-ng , Ionosphere , Dvswitch, YSFReflector , YSF2DMR , HBLink3 , Dashboard Websock

Dashboard html sobre websock , soporte GPSD , CM108 .

Ultima revision: emq-TE1ws-Rev9b 12/07/2021 

#

El proyecto Todo en uno (emq-TE1ws), es una compilación que reúne aplicaciones de diferentes desarrolladores, enfocadas para uso de radioaficionados.
Constante mente se trabaja en mejoras y actualizaciones, a medida que los desarrolladores de las aplicaciones incluidas lanzan nuevas versiones.

#

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
Puede instalar descargando la imagen ya compilada para Raspberry desde cualquiera de los siguientes enlaces : 

https://drive.google.com/file/d/1NM2a17NngY34Tb4GO6Ww0BstTRD8sjWe/view?usp=sharing

https://mega.nz/file/EVVwyZYL#tJlm6PvLX2xMIs3Jt8aep9itj3rpKbyuHE8D0deiJBI

Puede configurar desde consola terminal o utilizando aplicación cliente ssh

Usuario:    pi

Contraseña:  Panama507

Una vez allá iniciado sesión , escriba la palabra:   menu 

De esta forma accederá al listado de aplicaciones incluidas en la compilación y sus configuraciones, recuerde guardar los cambios con la combinación de teclas:     Ctrl + X , posteriormente iniciar o detener la aplicación ya configurada .

Si desea habilitar más de un Dashboard a la vez, recuerde cambiar los puertos para evitar conflictos, para esto se incluye dicha opción en el menú de pYSFReflector y MMDVMHost .

#
#WIFI 

Si su equipo cuenta con dispositivo de red inalámbrica (WIFI) o es modelo Raspberry Zero W , después de haber grabado la imagen en la memoria microSD con la herramienta Rufus , Balena u otra aplicación , debe descargar y copiar el archivo wpa_supplicant.conf, a la partición con el nombre boot en su memoria microSD.
Puede descargar el archivo wpa_supplicant.conf del siguiente link:

https://drive.google.com/file/d/1m-BJYz3T9LpEL76AirKPOhV228FZZ6lC/view?usp=sharing

Este archivo puede ser editado con el Notepad y dentro de este archivo, debe incluir los nombres de redes wifi y contraseñas de cada una, a las que desea que su raspberry se conecte, puede agregar una o cuantas redes wifi tenga, para que su equipo se conecte.

#
Exitos en sus proyectos con raspberry 

HP3ICC

Esteban Mackay Q.

73.
