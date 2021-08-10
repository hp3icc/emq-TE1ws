# emq-TE1ws
hp3icc Proyecto Todo en uno , MMDVMHost ,Direwolf , Multimon-ng , Ionosphere , Dvswitch, YSFReflector , YSF2DMR , HBLink3 , Dashboard Websock

Dashboard html sobre websock , soporte GPSD , CM108 .

Ultima revision: emq-TE1ws-Rev10a 9/8/2021 

#

El proyecto Todo en uno (emq-TE1ws), es una compilación que reúne aplicaciones de diferentes desarrolladores, enfocadas para uso de radioaficionados. Constante mente se trabaja en mejoras y actualizaciones, a medida que los desarrolladores de las aplicaciones incluidas lanzan nuevas versiones.
Todas las aplicaciones compiladas en esta imagen son 100% operativas, solo debe configurar sus parámetros e iniciar las aplicaciones que desee utilizar , según la capacidad y disponibilidad de su hardware .

Cualquier información sobre como configurar sus parámetros en las diferentes aplicaciones compiladas en esta imagen, debe dirigirse a los diferentes sitios de soporte de cada aplicación o desarrollador.

Especial agradecimiento al colega y amigo TI4OP Oscar , por sus aportes y revisiones de los scripts, para la creación del Bash de instalación de esta imagen.

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

FreeDMR

Esta versión cuenta con Dashboard HTML corriendo sobre websock , para el MMDVMHost y Reflector YSF , estan preconfigurados a puerto http 80 , pero desde el menú puede cambiar al puerto 8000, 8080 , o cualquier otro de su preferencia .

se agrega Librerias y aplicacion de gps y GPSD

Se agrega lista mundial de nombres de TG de la red DMR brandmeister .

Se agrega listado de nombres de salas del Proyecto Treehouse EUROPELINK según el DG-ID correspondiente .


Compatible con Raspberry pi : zero , P2 , P3 y P4

#

Puede descargara y utilizar el bash de instalacion con el siguiente comando :

wget https://github.com/hp3icc/emq-TE1ws/raw/main/emq-TE1ws-Rev10.sh

sh TE1ws-Rev10.sh

al finalizar la instalacion el equipo se reiniciara y podra accesar via ssh o por consola a la lista de aplicaciones escribiendo ( menu ) en su consola.

#
Puede instalar descargando la imagen ya compilada para Raspberry desde cualquiera de los siguientes enlaces : 

https://drive.google.com/file/d/1ag-VSgIvHesEsZdc0Txm8zRLmun4xJqQ/view?usp=sharing

https://mega.nz/file/5c9kEJCB#irCkt04H9fU5tXfVz6ZHssaY3XnPrO0SOiHNKxHec90

#

# Configuración

Puede configurar desde consola terminal o utilizando aplicación cliente ssh

Si descargo la imagen de Raspberry ya compilada estos son los datos para iniciar sesión:

Usuario:    pi

Contraseña:  Panama507

Una vez allá iniciado sesión , escriba la palabra:   menu 

De esta forma accederá al listado de aplicaciones incluidas en la compilación y sus configuraciones, recuerde guardar los cambios con la combinación de teclas:     Ctrl + X , posteriormente iniciar o detener la aplicación ya configurada .

Si desea habilitar más de un Dashboard a la vez, recuerde cambiar los puertos para evitar conflictos, para esto se incluye dicha opción en el menú de pYSFReflector y MMDVMHost .

#
# WIFI 

Si su equipo cuenta con dispositivo de red inalámbrica (WIFI) o es modelo Raspberry Zero W , después de haber grabado la imagen en la memoria microSD con la herramienta Rufus , Balena u otra aplicación , debe descargar y copiar el archivo wpa_supplicant.conf, a la partición con el nombre boot en su memoria microSD.
Puede descargar el archivo wpa_supplicant.conf del siguiente link:

https://drive.google.com/file/d/1m-BJYz3T9LpEL76AirKPOhV228FZZ6lC/view?usp=sharing

Este archivo puede ser editado con el Notepad y dentro de este archivo, debe incluir los nombres de redes wifi y contraseñas de cada una, a las que desea que su raspberry se conecte, puede agregar una o cuantas redes wifi tenga, para que su equipo se conecte.

#
Exitos en sus proyectos con raspberry 

HP3ICC

Esteban Mackay Q.

73.

#

# emq-TE1ws

 hp3icc All-in-one Project, MMDVMHost, Direwolf, Multimon-ng, Ionosphere, Dvswitch, YSFReflector, YSF2DMR, HBLink3, Dashboard Websock

 Html dashboard over websock, GPSD support, CM108.

 Last revision: emq-TE1ws-Rev10a 08/09/2021 

#

The All-in-one project (emq-TE1ws), is a compilation that brings together applications from different developers, focused on the use of radio amateurs. Improvements and updates are constantly being worked on, as the developers of the included applications release new versions.

All the applications compiled in this image are 100% operational, you just have to configure their parameters and start the applications you want to use, according to the capacity and availability of your hardware.

Any information on how to configure its parameters in the different applications compiled in this image should be directed to the different support sites of each application or developer.

Special thanks to the colleague and friend TI4OP Oscar, for his contributions and reviews of the scripts, for the creation of the installation Bash of this image.

#

List of amateur radio applications, including image and installation attempt:

 Direwolf 

 Muntimon-NG 

 Ionosphere

 MMDVMHost

 pYSFReflector 

 YSF2DMR

 Dvswitch 

 HBLink3
 
 FreeDMR


 This version has HTML Dashboard running on websock, for the MMDVMHost and YSF Reflector, they are preconfigured to http port 80, but from the menu you can change to port 8000, 8080, or any other of your preference.

 Libraries and gps and GPSD application is added

 Added worldwide list of TG names from DMR brandmeister network.

 A list of room names of the Treehouse EUROPELINK Project is added according to the corresponding DG-ID.

 Raspberry pi compatible: zero, P2, P3 and P4

 #

 You can download and use the install bash with the following command:

 wget https://github.com/hp3icc/emq-TE1ws/raw/main/emq-TE1ws-Rev10.sh

 sh TE1ws-Rev10.sh

 At the end of the installation the computer will restart and you will be able to access via ssh or by console to the list of applications by typing (menu) in your console.

 #

 You can install by downloading the already compiled Raspberry image from any of the following links: 

 https://drive.google.com/file/d/1ag-VSgIvHesEsZdc0Txm8zRLmun4xJqQ/view?usp=sharing

 https://mega.nz/file/5c9kEJCB#irCkt04H9fU5tXfVz6ZHssaY3XnPrO0SOiHNKxHec90

 #

 # Setting

 You can configure from terminal console or using ssh client application
 If I download the Raspberry image already compiled, these are the data to log in:

User: pi

Password: Panama507

Once logged in, write the word: menu 

In this way you will access the list of applications included in the compilation and their configurations, remember to save the changes with the key combination: Ctrl + X, then start or stop the already configured application.

If you want to enable more than one Dashboard at the same time, remember to change the ports to avoid conflicts, for this this option is included in the menu of pYSFReflector and MMDVMHost.

 #

 # WIFI 

If your computer has a wireless network device (WIFI) or is a Raspberry Zero W model, after having recorded the image in the microSD memory with the Rufus, Balena or other application, you must download and copy the wpa_supplicant.conf file, to the partition named boot on your microSD memory.

 You can download the wpa_supplicant.conf file from the following link:

 https://drive.google.com/file/d/1m-BJYz3T9LpEL76AirKPOhV228FZZ6lC/view?usp=sharing

 This file can be edited with the Notepad and within this file, you must include the names of Wi-Fi networks and passwords of each one, to which you want your raspberry to connect, you can add one or how many Wi-Fi networks you have, so that your equipment connect.

 #

 Successes in your projects with raspberry 

 HP3ICC
 
 Esteban Mackay Q.
 
 73.
#
