# emq-TE1ws ahora es emq-TE1+

# Nota importante, scrip no oficial de auto instalacion de diferentes aplicaciones  , consulte abajo los link para para utilizar los modos oficiales de instalacion y soporte de las diferentes aplicaciones
![alt text](https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/emq-TE1.png)

hp3icc Proyecto Todo en uno , MMDVMHost ,Direwolf , Multimon-ng , Ionosphere , Dvswitch, YSFReflector , YSF2DMR , HBLink3 , FreeDMR , NoIP , Dashboard Websock

Dashboard html sobre websock , soporte GPSD , CM108 .

Continuamente todo el contenido publicado aqui, es actualizado , si esta observando atravez de un link compartido , dirijase al link principal :

https://gitlab.com/hp3icc/emq-TE1

* Ultima revision: emq-TE1ws-Rev21 08/01/2023 

  Raspberry OS Lite Basado en la versión 11 de Debian (bullseye) 22-09-2022
  
  Linux kernel 5.15
  
#

El proyecto Todo en uno (emq-TE1ws), es una compilación que reúne aplicaciones de diferentes desarrolladores, enfocadas para uso de radioaficionados. Constante mente se trabaja en mejoras y actualizaciones, a medida que los desarrolladores de las aplicaciones incluidas lanzan nuevas versiones.
Todas las aplicaciones compiladas en esta imagen son 100% operativas, solo debe configurar sus parámetros e iniciar las aplicaciones que desee utilizar , según la capacidad y disponibilidad de su hardware .

Cualquier información sobre como configurar sus parámetros en las diferentes aplicaciones compiladas en esta imagen, debe dirigirse a los diferentes sitios de soporte de cada aplicación o desarrollador.

Especial agradecimiento al colega y amigo TI4OP Oscar , por sus aportes y revisiones de los scripts, para la creación del Bash de instalación de esta imagen.

#

Listado de aplicaciones de radioaficionados, que incluye la imagen y bash de instalación :

Direwolf 

Muntimon-NG 

MMDVMHost

DMRGateway

pYSFReflector 

YSF2DMR

Dvswitch 

FreeDMR

FDMR-Monitor

NoIP

GoTTY

Reuter WiFi-AP (opcional version - Reuter AP)

Esta versión cuenta con Dashboard HTML corriendo sobre websock , para el MMDVMHost y Reflector YSF , estan preconfigurados a puerto http 80 , pero desde el menú puede cambiar al puerto 8000, 8080 , o cualquier otro de su preferencia .

se agrega Librerias y aplicacion de gps y GPSD

Se agrega lista mundial de nombres de TG de la red DMR brandmeister .

Se agrega listado de nombres de salas del Proyecto Treehouse EUROPELINK según el DG-ID correspondiente .


Compatible con Raspberry pi : zero , P2 , P3 y P4

#

# Descargar imagen de micro sd para Raspberry:

si posee equipo raspbery , puede descargar y utilizar la imagen preconfigurada  lista para cargar en su memoria micro sd , para esto solo deberá descargar el archivo de la imagen preconfigurada para raspberry, descomprimir el archivo .zip y cargar en su memoria micro sd utilizando herramientas como BalenaEtcher , Rufus o cualquier otra herramienta para cargar el archivo .img a la memoria micro sd.

 Puede descargar la imagen para raspberry desde cualquiera de los siguientes links:
 
Imagen para raspberry, proyecto emq-TE1 - recomendado para cualquier Raspberry : Zero, Zero-W, Zero2, Zero2 W  B2, B3, B3+, PI4

* <p><a href="https://drive.google.com/u/0/uc?id=17DzFy8i-S1ISvr08QnI8rO7uEUov6K-4&export=download&confirm=t&uuid=4329f6b0-353d-44d1-b08b-2715faa32981" target="_blank">Descargar</a> imagen Raspberry&nbsp;</p>

#

# Instalación desde terminal:

Puede instalar en su sistema operativo (Ubuntu , raspberry , Debian ) utilizando el Bash de auto instalación desde su consola terminal con permisos de super usuario, importante su sistema operativo debe tener instalado sudo y curl  antes de utilizar el Bash de auto instalación .

* Pre-requisitos :
 
 curl
 
 sudo
 
* Bash de auto instalación :

       apt-get update
       
       apt-get install curl sudo -y
       
       sh -c "$(curl -fsSL https://gitlab.com/hp3icc/emq-TE1/-/raw/main/install.sh)"


#

# Configuración

Puede configurar desde consola terminal, aplicación cliente ssh o utilizar su navegador Web puerto 8022, ingresando al ip local de su raspberry o hostname.

Ejemplo: 

* 10.0.0.1:8022/  

* emq-te1:8022/ 

Usuario:    pi

Contraseña:  Panama507

si esta configurando desde terminal o clliente ssh, una vez allá iniciado sesión , escriba la palabra:   menu 

De esta forma accederá al listado de aplicaciones incluidas en la compilación y sus configuraciones, recuerde guardar los cambios con la combinación de teclas:     Ctrl + X , posteriormente iniciar o detener la aplicación ya configurada .

A partir de version 12d , se agrega funcion de reinicio automatico del equipo , esto es posible mendiamte prueba de ping al internet cada 1 minuto, esta fumcion esta apagada , si desea utilizar , entre al menu de reinicio de equipo y habilite  

Si desea habilitar más de un Dashboard a la vez, recuerde cambiar los puertos http para evitar conflictos, para esto se incluye dicha opción en el menú de :

* pYSFReflector  
* MMDVMHost
* Dvswitch
* FreeDMR

# Nota importante 

* Si utiliza la imagen pre-compilada para Raspberry , recuerde cambiar la contraseña por una de su preferencia . 

#

# WIFI 

Si su equipo cuenta con dispositivo de red inalámbrica (WIFI) o es modelo Raspberry Zero W , después de haber grabado la imagen en la memoria microSD con la herramienta Rufus , Balena u otra aplicación , copiar el archivo wpa_supplicant.conf, a la partición con el nombre boot en su memoria microSD.
Puede descargar el archivo wpa_supplicant.conf del siguiente link:

<p><a href="http://wpa.ddns.net/" target="_blank">wpasupplicant.conf generator</a>

 Puede agregar cuantas redes wifi sea necesario, utilizando el botón Add Network.

cuando alla agregado todas las redes wifi que utilizara en el generador de wpasupplicant , dele click al botón Donwload wpa_supplicant.conf , el archivo descargado copielo en la partición boot de la memoria micro sd .

Con este procedimiento ya podrá utilizar su raspberry en cualquiera de las redes wifi configuradas.

#

# Reuter WiFi-AP

Ahora el proyecto emq-TE1ws , incluye la funcion de modo Reuter Wifi AP, a nuestro equipo, esta funcion nos permite utilizar nuestro mini computador Raspberry como un reuter WiFi o si tenemos un hotspot o aprs sobre raspberry zero W, nos facilita la conexion a nuestro equipo , para agregar una nueva coneccion a redes wifi conocidas .

La funcion de de WiFi-AP puede ser apagada o encendida en el menu wifi

Para conectarse a su equipo, selecciones la red wifi con el nombre:

emq-TE1-AP

contraseña para su coneccion wifi:

Panama507

Para cambiar el nombre y la contraseña de su WiFi-AP , entre al menu editar wifi , luego en editar AP WiFi, y reemplace el nombre actual en la linea ssid= :

ssid=HP3ICC-1HS

la contraseña debe ingresarla en formato hexadecimal, reemplasando la actual que esta en la linea  wpa_psk= :

wpa_psk=cdfce0488f50bac6d77d911e44b33d5c9c7652dc7c7f81c6489bac8a683e04a1

Para generar su contraseña correctamente en formato hexadecimal, es el calculo entre el ssid y su contraseña alfanumerica, puede utilizar el siguiente link, ingresando sus datos y luego dar click en generar :

http://jorisvr.nl/wpapsk.html


* Nota:

  Para habilitar el moodo Reuter wifi Ap , ingrece al menu upgrade ,luego en update list y selecione upgrade to Reuter AP mode.

#

# DMRGateway

DMRGateway permite tener nuestro hotspot , dmo , o repetidor dmr; conectado a mas de una red de la modalidad dmr, para esto es necesario seleccionar conexion Gateway en la configuracion del mmdvmhost , y en los radios se debe reconfigurar los numeros de tg segun la red a utilizar .

DMRGateway esta configurado para soportar numeros de tg hasta 6 digitos , si el numero de tg a utilizar tiene menos de 6 digitos , debe completar con ceros hasta llegar a 6 digitos .

Cada servidor DMR conectado a DMRGateway tiene un numero de 1 a 5, que lo identifica y diferencia segun la red a utilizar , y estan distribuidos de la siguiente forma :

  1 Brandmeister
  
  2 FreeDMR
  
  3 TGif Network
  
  4 DMR Central
  
  5 Freestar
  
Cada tg que utilicemos en nuestros radios deve estar cumplir con 6 digitos y estar acompañado del numero de servidor por el cual debe enviarce nuestra transmision.

Ejemplo de configuracion tg en sus radios para diferentes redes:

TG        Red             Nombre TG         DMRGateway

714       FreeDMR         Panama            2000714

7144      FreeDMR         CHIRIQUI LINK     2007144

2147      DMR Central     Regional-EA7      4002147

Cada tg almacenado en nuestros radios debe completar 6 digitos y estar precesido por el numero de servidor dmr a utilizar , cuando se reciban transmiciones de internet a nuestro hotspot , se recibiran de la misma forma, 6 digitos mas el numero de red que estamos recibiendo .

#

# Links:

Direwolf : https://github.com/wb2osz/direwolf

Muntimon-NG : https://github.com/EliasOenal/multimon-ng

Ionosphere : https://github.com/cceremuga/ionosphere

MMDVMHost : https://github.com/g4klx/MMDVMHost

DMRGateway : https://github.com/g4klx/DMRGateway

pYSFReflector : https://github.com/iu5jae/pYSFReflector3

YSF2DMR : https://github.com/juribeparada/MMDVM_CM

Dvswitch : https://dvswitch.groups.io/g/main?

FreeDMR : https://gitlab.hacknix.net/hacknix/FreeDMR/-/wikis/Installing-using-Docker-(recommended!)

FDMR-Monitor : https://github.com/yuvelq/FDMR-Monitor/tree/Self_Service

NoIP : https://www.noip.com/

GoTTY : https://github.com/yudai/gotty/


#

Exitos en sus proyectos con raspberry 

HP3ICC

Esteban Mackay Q.

73.

#
