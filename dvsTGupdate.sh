sudo cat > /usr/local/dvs/dvs <<- "EOF"
#!/bin/bash

#===================================
SCRIPT_VERSION="Menu Script v.1.61"
SCRIPT_AUTHOR="HL5KY"
SCRIPT_DATE="11/06/2020"
#===================================

source /var/lib/dvswitch/dvs/var.txt

if [ "$1" != "" ]; then
    case $1 in
        -v|-V|--version) echo "dvs "$SCRIPT_VERSION; exit 0 ;;
        -a|-A|--author) echo "dvs "$SCRIPT_AUTHOR; exit 0 ;;
        -d|-D|--date) echo "dvs "$SCRIPT_DATE; exit 0 ;;
          *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
fi

#--------------------------------------------------------------------

clear

# After upgrading, if [there is dvsm.basic] -> meaning setting is Advanced Macro Configuration
if [ -e ${AB}dvsm.basic ]; then
#    if there is not character "Advanced" in dvsm.macro -> updated & upgraded and dvsm.macro is brand new
        if [[ -z `grep "Advanced" ${AB}dvsm.macro` ]]; then
                sudo \cp -f ${adv}dvsm.macro ${AB}dvsm.macro
        fi
fi


if [ -e /var/lib/dvswitch/dvs/var.old ]; then
clear
sudo \mv -f /var/lib/dvswitch/dvs/var.old /var/lib/dvswitch/dvs/var.txt
source /var/lib/dvswitch/dvs/var.txt
fi


if [ ! -e ${lan}language.txt ]; then
clear
sudo \cp -f ${lan}english.txt ${lan}language.txt
source /var/lib/dvswitch/dvs/var.txt
fi


if [ "$startup_lan" != "73" ]; then

clear

update_var startup_lan 73

	if (whiptail --title " Change Language Settings " --yesno "\

           Do you want to change Language settings now ?


           You can do it later. The menu is under <Tools>
	" 12 70); then
	${DVS}language.sh; exit 0
	fi
fi


#--------------------------------------------------------------------

OPTION=$(whiptail --title " $T010 " --menu "\
                                           $SCRIPT_VERSION\n
\n
" 14 110 6 \
"01 $T011     " "$T012" \
"02 $T013     " "$T014" \
"03 $T015     " "$T016" \
"04 $T023     " "$T024" \
"05 $T017     " "$T018" \
"06 $T019     " "$T020" 3>&1 1>&2 2>&3)

if [ $? != 0 ]; then
clear;
exit 0
fi

case $OPTION in
01\ *)sudo ${DVS}init_config.sh ;;
02\ *)sudo ${DVS}adv_config_menu.sh ;;
03\ *)sudo ${DVS}tools_menu.sh ;;
04\ *)sh -c "$(curl -fsSL https://github.com/hp3icc/emq-TE1ws/raw/main/service/dv-list-tg.sh)" ;;
05\ *)sudo ${DVS}credits.sh ;;
06\ *)exit 0
esac

#exit 0

EOF
###
sudo cat > /var/lib/dvswitch/dvs/lan/language.txt <<- "EOF"
#=====================================================================================================#
#                                                                                                     #
# Language file for the scripts.                                                                      #
#                                                                                                     #
# Translate and change words only in the quotation marks                                              #
# If there is a number inside quotation mark, leave it as it is.                                      #
# Some words and phrases are easy enough for non-English speaking people to understand.               #
# If you don't think you need to translate some words or phrases, Just leave them in English.         #
# The length of the line can be a bit longer, about 5 more characters                                 #
# Please don't worry too much about the length or format. We will check them to suit to the scripts.  #
#                                                                                                     #
#=====================================================================================================#


#LN="EN"   ; Change the value of <LN> with 2-digit character, like "EN" "ES" or "FR"
LN="EN"
#language="English"    ; Your language in English, like French, German, Chinese
language="English"
#language_your_alphabet="English"    ; How to write your language in your alphabet, like Deutsch.... 
language_your_alphabet="English"

menu_translator=""
doc_translator=""
lan_ver=""


# General ================================
#T000="You are already using ISO639"     ; Change ISO639 to your language in your alphabet 
T000="You are already using English"
#T001="SAVE"
T001="SAVE"
#T002="CANCEL"
T002="CANCEL"
#T003="Finished"
T003="Finished"
#T004="<Enter> to MENU"
T004="<Enter> to MENU"
#T005="<Yes> to Continue, <No> to Cancel"
T005="<Yes> to Continue, <No> to Cancel"
#T006="Please WAIT"
T006="Please WAIT"
#T007="Edit"
T007="Edit"
#T008="Press <ENTER> to continue"
T008="Press <ENTER> to continue"
#T009="Input"
T009="Input"


# dvs ====================================
#T010="MAIN MENU"
T010="MAIN MENU"
#T011="Initial Configuration"
T011="Initial Configuration"
#T012="Enter Callsign, DMR ID, BM Server and AMBE"
T012="Enter Callsign, DMR ID, BM Server and AMBE"
#T013="Advanced Configuration"
T013="Advanced Configuration"
#T014="TG/Ref Manage, Macro, DMR Networks"
T014="TG/Ref Manage, Macro, DMR Networks"
#T015="Tools"
T015="Tools"
#T016="SD Card Clone, Upgrade, Language, Reboot/Shutdown"   ; Keep the length same or shorter
T016="SD Card Clone, Upgrade, Language, Reboot/Shutdown"
#T017="Credits"
T017="Credits"
#T018="Credits of DVSwitch and Menu Scripts"
T018="Credits of DVSwitch and Menu Scripts"
#T019="Exit"
T019="Exit"
#T020="Exit DVSwitch Menu"
T020="Exit DVSwitch Menu"
#T023="Select TG List"
T023="Select TG List"
#T024="FreeDMR / BM"
T024="FreeDMR / BM"

# dvsb====================================
#T025="Configuration for Prerequisite Items"
T025="Configuration for Prerequisite Items"
#T026="Configure prerequisite items for DVSwitch."
T026="Configure prerequisite items for DVSwitch."
#T029="Working"       ; the work is in progress
T029="Working"


# Contents of Credits
#T030="DVSwitch : Mike N4IRR and Steve N4IRS"
T030="DVSwitch : Mike N4IRR and Steve N4IRS"
#T031="Menu Script and Macro : HL5KY"
T031="Menu Script and Macro : HL5KY"
#T032="English Documentation : W8RIK and K2KXK"
T032="English Documentation : W8RIK and K2KXK"
#T033="Menu Script Translation :"
T033="Menu Script Translation :"
#T034="ISO639 Documentation : "        ; Change ISO639 to your language in your alphabet 
T034="ISO639 Documentation : "
#T035="Dashboard : SP2ONG"
T035="Dashboard : SP2ONG"

# init_config.sh =========================
#T150="Previous Configuration notice"
T150="Previous Configuration notice"
#T151="You already have a previous configuration :"
T151="You already have a previous configuration :"
#T152="Ad Hoc menu & macros will be updated/initialized and changes will be lost."
T152="Ad Hoc menu & macros will be updated/initialized and changes will be lost."

#T154="Initial Configuration"
T154="Initial Configuration"
#T155="This process will ask you Callsign, DMR ID, USRP port, Hardware AMBE.... for ini. files."
T155="This process will ask you Callsign, DMR ID, USRP port, Hardware AMBE.... for ini. files."
#T160="Callsign? (case-insensitive)"
T160="Callsign? (case-insensitive)"
#T161="NXDN ID? (Enter for none)"
T161="NXDN ID? (Enter for none)"
#T162="password for Brandmeister (Enter if not changed)"
T162="Enter your personalized hotspot password configured via Brandmeister SelfCare, if applicable, otherwise leave as default."
#T163="Choose your local BM Server"
T163="Choose your local BM Server"

#T165="CCS7/DMR ID should be 7 digits"
T165="CCS7/DMR ID should be 7 digits"
#T166="2 digit number"
T166="2 digit number"
#T167="should be 9 digits"
T167="should be 9 digits"
#T168="460800 (old version: 230400)"
T168="460800 (old version: 230400)"

#T170="Hardware Vocoder (AMBE)"
T170="Hardware Vocoder (AMBE)"
#T171="1 AMBE Server"
T171="1 AMBE Server"
#T172="External AMBE Server e.g., ZumAMBE Server"       ; Keep the length same or shorter
T172="External AMBE Server e.g., ZumAMBE Server"
#T173="2 USB Type AMBE"
T173="2 USB Type AMBE"
#T174="ThumbDV, DVstick"
T174="ThumbDV, DVstick"
#T175="3 GPIO type AMBE"
T175="3 GPIO type AMBE"
#T176="DV3000 or PAMBE Board"
T176="DV3000 or PAMBE Board"
#T177="4 No Hardware Vocoder"
T177="4 No Hardware Vocoder"
#T178="Use Software Vocoder"
T178="Use Software Vocoder"

#T180="Input Finished"
T180="Input Finished"
#T181="Input for Initial Configuration Finished."
T181="Input for Initial Configuration Finished."
#T182="ini files' Configuration will start."
T182="ini files' Configuration will start."
#T185="Processing Initial Configuration"
T185="Processing Initial Configuration"

#T190="Initial Configuration Finished"
T190="Initial Configuration Finished"
#T191="You can start using DVSwitch after REBOOTing"
T191="You can start using DVSwitch after REBOOTing"
#T192="System will REBOOT and SSH will be disconnected."
T192="System will REBOOT and SSH will be disconnected."
#T193="<Yes> to REBOOT, or <No> back to MENU"
T193="<Yes> to REBOOT, or <No> back to MENU"
#T194="DVSwitch Server is up and running"
T194="DVSwitch Server is up and running"
#T195="Press <ENTER> to finish Configuration"
T195="Press <ENTER> to finish Configuration"


# adv_config_menu.sh =============================
#T200="Advanced Configuration Menu"
T200="Advanced Configuration Menu"
#T201="Configure Favorite TG/Ref"
T201="Configure Favorite TG/Ref"
#T202="Edit Favorite TGs and Reflectors, Push to DVSM/UC"     ; Keep the length same or shorter
T202="Edit Favorite TGs and Reflectors, Push to DVSM/UC"
#T203="Ad Hoc Menu & Macro"
T203="Ad Hoc Menu & Macro"
#T204="Managing Ad Hoc Menu and Macro"
T204="Managing Ad Hoc Menu and Macro"
#T205="Additional DMR Networks"
T205="Additional DMR Networks"
#T206="Setup for DMRPlus, TGIF and other Networks"
T206="Setup for DMRPlus, TGIF and other Networks"
#T207="Back"
T207="Back"
#T208="Return to MAIN MENU"
T208="Return to MAIN MENU"
#T209="Configure other stanzas"
T209="Configure other stanzas"
#T210="Freq, Pwr, Lat, Long, Location ...."
T210="Freq, Pwr, Lat, Long, Location ...."


# config_ini.sh ============================
#T211="Configure ini. files"
T211="Configure ini. files"


# config_other_stz.sh ============================
#T213="RX Frequency (xxx.xxxx MHz)"
T213="RX Frequency (xxx.xxxx MHz)"
#T214="TX Frequency (xxx.xxxx MHz)"
T214="TX Frequency (xxx.xxxx MHz)"
#T215="This process will ask you the parameters in [Info] section of MMDVM_Bridge.ini"
T215="This process will ask you the parameters in [Info] section of MMDVM_Bridge.ini"
#T216="RX Frequency (xxx.xxxx MHz, with 4 decimal digits)"
T216="RX Frequency (xxx.xxxx MHz, with 4 decimal digits)"
#T217="TX Frequency (xxx.xxxx MHz, with 4 decimal digits)"
T217="TX Frequency (xxx.xxxx MHz, with 4 decimal digits)"
#T218="Latitude (xxx.xxxx or -xxx.xxxx)"
T218="Latitude (xxx.xxxx or -xxx.xxxx)"
#T219="Longitude (xxx.xxxx or -xxx.xxxx)"
T219="Longitude (xxx.xxxx or -xxx.xxxx)"
#T220="Power"
T220="Power"
#T221="Height"
T221="Height"
#T222="Location"
T222="Location"
#T223="Description"
T223="Description"


# tg_db.sh =============================
#T239="TG/Ref DB Management"
T239="TG/Ref DB Management"
#T249="Push to DVSM/UC"
T249="Push to DVSM/UC"
#T250="PUSH (Favorite DB + Global DB)"
T250="PUSH (Favorite DB + Global DB)"
#T251="Make sure you read <...success> on DVSM/UC"
T251="Make sure you read <...success> on DVSM/UC"
#T252="Reset Favorite DB"
T252="Reset Favorite DB"
#T253="Favorite TG/Ref will be initialized."
T253="Favorite TG/Ref will be initialized."
#T254="After resetting, it will push files to DVSM/UC"
T254="After resetting, it will push files to DVSM/UC"


# adhoc_basic.sh ===========================
#T260="BASIC Macro Configuration"
T260="BASIC Macro Configuration"
#T261="You are using BASIC Macro Configuration"
T261="You are using BASIC Macro Configuration"
#T262="Do you want to change to Advanced Macro Configuration?"
T262="Do you want to change to Advanced Macro Configuration?"
#T263="All macro files were changed to the Advanced macro."
T263="All macro files were changed to the Advanced macro."
#T264="DVSwitch services were restarted."
T264="DVSwitch services were restarted."


# adhoc_adv.sh =============================
#T270="<ADVANCED>"
T270="<ADVANCED>"
#T273="To apply editing, <Restart DVSwitch>"
T273="To apply editing, <Restart DVSwitch>"
#T274="<ADVANCED Macro>"
T274="<ADVANCED Macro>"
#T275="Restart DVSwitch Services"
T275="Restart DVSwitch Services"
#T276="Change to <BASIC> dvsm.macro"
T276="Change to <BASIC> dvsm.macro"
#T277="Back to Advanced Configuration Menu"
T277="Back to Advanced Configuration Menu"
#T278="All macro files were changed back to the basic which is DVSwitch default macro."
T278="All macro files were changed back to the basic which is DVSwitch default macro."


# adnl_dmr.sh =================================
#T280="Choose DMRPlus server"
T280="Choose DMRPlus server"
#T282="IP or DNS of TGIF Server"
T282="IP or DNS of TGIF Server"
#T283="Password of TGIF Server"
T283="Password of TGIF Server"
#T284="Port of TGIF Server"
T284="Port of TGIF Server"
#T286="Name of other Network (no space)"
T286="Name of other Network (no space)"
#T287="IP or DNS of other Networks"
T287="IP or DNS of other Networks"
#T288="Password of other Networks"
T288="Password of other Networks"
#T289="Port of other Networks"
T289="Port of other Networks"


# Tools_menu.sh ===============================
#T300="Tools Menu"
T300="Tools Menu"
#T301="Clone RPi SD Card"
T301="Clone RPi SD Card"
#T302="Clone SD Card to a new one"
T302="Clone SD Card to a new one"
#T303="Configure ini. files"
T303="Configure ini. files"
#T304="Analog_Bridge.ini, MMDVM_Bridge.ini... Files"        ; Keep the length same or shorter
T304="Analog_Bridge.ini, MMDVM_Bridge.ini... Files"
#T305="Update & Upgrade"
T305="Update & Upgrade"
#T306="Update & Upgrade"
T306="Update & Upgrade"
#T307="Language"
T307="Language"
#T308="Select Language for DVSwitch Menus"
T308="Select Language for DVSwitch Menus"

#T311="Restart DVSwitch Services"
T311="Restart DVSwitch Services"
#T312="Restart Analog & MMDVM Services (2sec)"
T312="Restart Analog & MMDVM Services (2sec)"
#T313="Reboot RPi Server"
T313="Reboot RPi Server"
#T314="Reboot Raspberry Pi Server (30sec)"
T314="Reboot Raspberry Pi Server (30sec)"
#T315="Shutdown RPi Server"
T315="Shutdown RPi Server"
#T316="Shutdown Raspberry Pi"
T316="Shutdown Raspberry Pi"
#T317="Back"
T317="Back"
#T318="Return to MAIN MENU"
T318="Return to MAIN MENU"

#T322="Show system information"
T322="Show system information"

#T330="Temperature message"
T330="Temperature message"
#T331="Enable/Disable temperature message"
T331="Enable/Disable temperature message"
#T332="Enable to send CPU temperature message"
T332="Enable to send CPU temperature message"
#T333="Disable to send CPU temperature message"
T333="Disable to send CPU temperature message"


# clone.sh ===================================
#T350="You can make a back-up or clone of the present installation."
T350="You can make a back-up or clone of the present installation."
#T351="- The new SD card can be same or smaller size card."
T351="- The new SD card can be same or smaller size card."
#T352="- Use formatted/clean SD card."
T352="- Use formatted/clean SD card."
#T353="To start cloning, plug USB card reader into the Pi, with SD card."
T353="To start cloning, plug USB card reader into the Pi, with SD card."
#T354="You need to check the device first whether it is recognized by Pi."
T354="You need to check the device first whether it is recognized by Pi."
#T355="<Yes> to start checking device, <No> to Cancel"
T355="<Yes> to start checking device, <No> to Cancel"
#T356="Re-cloning onto the same SD card takes about 1 min."
T356="Re-cloning onto the same SD card takes about 1 min."

#T360="Destination Drive"
T360="Destination Drive"
#T361="Do you want to start cloning?"
T361="Do you want to start cloning?"

#T363="There is no storage device(s) in the Pi."
T363="There is no storage device(s) in the Pi."
#T364="Please check the USB card reader and/or SD card."
T364="Please check the USB card reader and/or SD card."

#T365="During the process, you will be asked three times:"
T365="During the process, you will be asked three times:"
#T366="1. First, ask for reformatting (initializing), type <yes>"
T366="1. First, ask for reformatting (initializing), type <yes>"
#T367="2. Second, enter file label, just press <Enter>"
T367="2. Second, enter file label, just press <Enter>"
#T368="3. Finally, hit the <Enter> to finalize (unmount)."
T368="3. Finally, hit the <Enter> to finalize (unmount)."


# update_upgrade.sh ===========================
#T380="This will check for available package upgrades."
T380="This will check for available package upgrades."
#T381="Followings are upgradable"
T381="Followings are upgradable"
#T382="apt-get update and check for upgrade"
T382="apt-get update and check for upgrade"
#T383="There are no packages to upgrade."
T383="There are no packages to upgrade."
#T386="Total number of packages to upgrade :"
T386="Total number of packages to upgrade :"
#T387="Number of packages for DVSwitch :"
T387="Number of packages for DVSwitch :"
#T388="Number of packages for system and others :"
T388="Number of packages for system and others :"
#T390="<Yes> to upgrade, <No> to cancel"
T390="<Yes> to upgrade, <No> to cancel"
#T392="update & upgrade was completed."
T392="update & upgrade was completed."
#T393="DVSwitch Services will restart."
T393="DVSwitch Services will restart."
#T394="DVSwitch Services Restarting"
T394="DVSwitch Services Restarting"


# adnl_dmr.sh =================================
#T400="DMR Networks"
T400="DMR Networks"
#T401="DMRPlus Network"
T401="DMRPlus Network"
#T402="TGIF Network"
T402="TGIF Network"
#T403="Other1 Network"
T403="Other1 Network"
#T404="Other2 Network"
T404="Other2 Network"
#T405="Brandmeister Network"
T405="Brandmeister Network"

#T406="Current Setup"
T406="Current Setup"
#T407="Network name"
T407="Network name"
#T408="Server address"
T408="Server address"
#T409="Password"
T409="Password"
#T410="USRP Port? (Recommand: 50000~55000, None: default)"
T410="USRP Port? (Recommand: 50000~55000, None: default)"
#T411="Select for Default Network"
T411="Select for Default Network"
#T412="Set this Network as a Default Server for DMR?"
T412="Set this Network as a Default Server for DMR?"
#T413="default"
T413="default"

#T415="Do you want to change the setup?"
T415="Do you want to change the setup?"
#T416="Do you want to set the network?"
T416="Do you want to set the network?"
#T417="Change Default DMR Server"
T417="Change Default DMR Server"
#T418="Configure DMR Server"
T418="Configure DMR Server"
#T419="Current Server"
T419="Current Server"
#T420="There is no configured DMR Network"
T420="There is no configured DMR Network"
#T421="is default DMR Server."       # There is a subject before the sentence.
T421="is default DMR Server."
#T422="You can't delete it."
T422="You can't delete it."
#T423="There is no configured DMR Network."
T423="There is no configured DMR Network."


# Spaces =====================================
sp01=" "
sp02="  "
sp03="   "
sp04="    "
sp05="     "
sp06="      "
sp07="       "
sp08="        "
sp09="         "
sp10="          "
sp11="           "
sp12="            "
sp13="             "
sp14="              "
sp15="               "
sp16="                "
sp17="                 "
sp18="                  "
sp19="                   "
sp20="                    "
sp21="                     "
sp22="                      "
sp23="                       "
sp24="                        "
sp25="                         "
sp26="                          "
sp27="                           "
sp28="                            "
sp29="                             "
sp30="                              "

EOF
##
sudo cat > /var/lib/dvswitch/dvs/lan/spanish.txt <<- "EOF"
#=====================================================================================================#
#                                                                                                     #
# Language file for the scripts.                                                                      #
#                                                                                                     #
# Translate and change words only in the quotation marks                                              #
# If there is a number inside quotation mark, leave it as it is.                                      #
# Some words and phrases are easy enough for non-English speaking people to understand.               #
# If you don't think you need to translate some words or phrases, Just leave them in English.         #
# The length of the line can be a bit longer, about 5 more characters                                 #
# Please don't worry too much about the length or format. We will check them to suit to the scripts.  #
#                                                                                                     #
#=====================================================================================================#


#LN="EN"   ; Change the value of <LN> with 2-digit character, like "EN" "ES" or "FR"
LN="ES"
#language="English"    ; Your language in English, like French, German, Chinese
language="Spanish"
#language_your_alphabet="English"    ; How to write your language in your alphabet, like Deutsch.... 
language_your_alphabet="EspaÃ±ol"

menu_translator="Google"
doc_translator=""
lan_ver=""


# General ================================
#T000="You are already using ISO639"     ; Change ISO639 to your language in your alphabet 
T000="Ya estÃ¡s usando EspaÃ±ol"
#T001="SAVE"
T001="SALVAR"
#T002="CANCEL"
T002="CANCELAR"
#T003="Finished"
T003="Terminado"
#T004="<Enter> to MENU"
T004="<Entrar> al MENÃš"
#T005="<Yes> to Continue, <No> to Cancel"
T005="<SÃ­> para continuar, <No> para cancelar"
#T006="Please WAIT"
T006="Por favor espera"
#T007="Edit"
T007="Editar"
#T008="Press <ENTER> to continue"
T008="Presione <ENTER> para continuar"
#T009="Input"
T009="Entrada"


# dvs ====================================
#T010="MAIN MENU"
T010="MENÃš PRINCIPAL"
#T011="Initial Configuration"
T011="Configuracion inicial"
#T012="Enter Callsign, DMR ID, BM Server and AMBE"
T012="Ingrese indicativo de llamada, ID de DMR, servidor BM y AMBE"
#T013="Advanced Configuration"
T013="ConfiguraciÃ³n avanzada"
#T014="TG/Ref Manage, Macro, DMR Networks"
T014="TG / Ref Manage, Macro, Redes DMR"
#T015="Tools"
T015="Herramientas"
#T016="SD Card Clone, Upgrade, Language, Reboot/Shutdown"   ; Keep the length same or shorter
T016="ClonaciÃ³n de tarjeta SD, actualizaciÃ³n, idioma, reinicio / apagado"
#T017="Credits"
T017="CrÃ©ditos"
#T018="Credits of DVSwitch and Menu Scripts"
T018="CrÃ©ditos de DVSwitch y Menu Scripts"
#T019="Exit"
T019="Salida"
#T020="Exit DVSwitch Menu"
T020="Salir del menÃº DVSwitch"
#T023="Select TG List"
T023="Select TG List"
#T024="FreeDMR / BM"
T024="FreeDMR / BM"


# dvsb====================================
#T025="Configuration for Prerequisite Items"
T025="ConfiguraciÃ³n de elementos de requisitos previos"
#T026="Configure prerequisite items for DVSwitch."
T026="Configure los elementos de requisitos previos para DVSwitch."
#T029="Working"       ; the work is in progress
T029="Trabajando"


# Contents of Credits
#T030="DVSwitch : Mike N4IRR and Steve N4IRS"
T030="DVSwitch: Mike N4IRR y Steve N4IRS"
#T031="Menu Script and Macro : HL5KY"
T031="Script de menÃº y macro: HL5KY"
#T032="English Documentation : W8RIK and K2KXK"
T032="DocumentaciÃ³n en inglÃ©s: W8RIK y K2KXK"
#T033="Menu Script Translation :"
T033="TraducciÃ³n de guiones de menÃº:"
#T034="ISO639 Documentation : "        ; Change ISO639 to your language in your alphabet 
T034="DocumentaciÃ³n EspaÃ±ol:"
#T035="Dashboard : SP2ONG"
T035="Tablero: SP2ONG"


# init_config.sh =========================
#T150="Previous Configuration notice"
T150="Aviso de configuraciÃ³n anterior"
#T151="You already have a previous configuration :"
T151="Ya tienes una configuraciÃ³n previa:"
#T152="Ad Hoc menu & macros will be updated/initialized and changes will be lost."
T152="MenÃº ad hoc"

#T154="Initial Configuration"
T154="Configuracion inicial"
#T155="This process will ask you Callsign, DMR ID, USRP port, Hardware AMBE.... for ini. files."
T155="Este proceso le pedirÃ¡ indicativo de llamada, ID de DMR, puerto USRP, hardware AMBE ... para ini. "
#T160="Callsign? (case-insensitive)"
T160="Â¿SeÃ±al de llamada? "
#T161="NXDN ID? (Enter for none)"
T161="ID NXDN? "
#T162="password for Brandmeister (Enter for none)"
T162="contraseÃ±a para Brandmeister (Ingrese para ninguna)"
#T163="Choose your local BM Server"
T163="Elija su servidor BM local"

#T165="CCS7/DMR ID should be 7 digits"
T165="El ID de CCS7 / DMR debe tener 7 dÃ­gitos"
#T166="2 digit number"
T166="NÃºmero de 2 dÃ­gitos"
#T167="should be 9 digits"
T167="debe tener 9 dÃ­gitos"
#T168="460800 (old version: 230400)"
T168="460800 (versiÃ³n antigua: 230400)"

#T170="Hardware Vocoder (AMBE)"
T170="Codificador de voz por hardware (AMBE)"
#T171="1 AMBE Server"
T171="1 servidor AMBE"
#T172="External AMBE Server e.g., ZumAMBE Server"       ; Keep the length same or shorter
T172="Servidor AMBE externo, por ejemplo, servidor ZumAMBE"
#T173="2 USB Type AMBE"
T173="2 USB tipo AMBE"
#T174="ThumbDV, DVstick"
T174="ThumbDV, DVstick"
#T175="3 GPIO type AMBE"
T175="3 tipo GPIO AMBE"
#T176="DV3000 or PAMBE Board"
T176="Tarjeta DV3000 o PAMBE"
#T177="4 No Hardware Vocoder"
T177="4 Sin codificador de voz de hardware"
#T178="Use Software Vocoder"
T178="Utilizar software Vocoder"


#T180="Input Finished"
T180="Entrada finalizada"
#T181="Input for Initial Configuration Finished."
T181="Entrada para configuraciÃ³n inicial finalizada."
#T182="ini files' Configuration will start."
T182="Se iniciarÃ¡ la configuraciÃ³n de los archivos ini."
#T185="Processing Initial Configuration"
T185="Procesamiento de la configuraciÃ³n inicial"

#T190="Initial Configuration Finished"
T190="ConfiguraciÃ³n inicial finalizada"
#T191="You can start using DVSwitch after REBOOTing"
T191="Puede comenzar a utilizar DVSwitch despuÃ©s de REINICIAR"
#T192="System will REBOOT and SSH will be disconnected."
T192="El sistema se REINICIARÃ y SSH se desconectarÃ¡."
#T193="<Yes> to REBOOT, or <No> back to MENU"
T193="<SÃ­> para REINICIAR, o <No> volver al MENÃš"
#T194="DVSwitch Server is up and running"
T194="DVSwitch Server estÃ¡ en funcionamiento"
#T195="Press <ENTER> to finish Configuration"
T195="Presione <ENTER> para finalizar la ConfiguraciÃ³n"


# adv_config_menu.sh =============================
#T200="Advanced Configuration Menu"
T200="MenÃº de configuraciÃ³n avanzada"
#T201="Configure Favorite TG/Ref"
T201="Configurar TG / Ref favorito"
#T202="Edit Favorite TGs and Reflectors"     ; Keep the length same or shorter
T202="Editar reflectores y TG favoritos"
#T203="Ad Hoc Menu & Macro"
T203="MenÃº ad hoc"
#T204="Managing Ad Hoc Menu and Macro"
T204="GestiÃ³n de macros y menÃºs ad hoc"
#T205="Additional DMR Networks"
T205="Redes DMR adicionales"
#T206="Setup for DMRPlus, TGIF and other Networks"
T206="ConfiguraciÃ³n para DMRPlus, TGIF y otras redes"
#T207="Back"
T207="atrÃ¡s"
#T208="Return to MAIN MENU"
T208="Volver al menÃº principal"
#T209="Configure other stanzas"
T209="Configurar otras estrofas"
#T210="Freq, Pwr, Lat, Long, Location ...."
T210="Freq, Pwr, Lat, Long, Location ...."


# config_ini.sh ============================
#T211="Configure ini. files"
T211="Configure ini. "


# config_other_stz.sh ============================
#T213="RX Frequency (xxx.xxxx MHz)"
T213="Frecuencia RX (xxx.xxxx MHz)"
#T214="TX Frequency (xxx.xxxx MHz)"
T214="Frecuencia TX (xxx.xxxx MHz)"
#T215="This process will ask you the parameters in [Info] section of MMDVM_Bridge.ini"
T215="Este proceso le pedirÃ¡ los parÃ¡metros en la secciÃ³n [InformaciÃ³n] de MMDVM_Bridge.ini"
#T216="RX Frequency (xxx.xxxx MHz, with 4 decimal digits)"
T216="Frecuencia RX (xxx.xxxx MHz, con 4 dÃ­gitos decimales)"
#T217="TX Frequency (xxx.xxxx MHz, with 4 decimal digits)"
T217="Frecuencia TX (xxx.xxxx MHz, con 4 dÃ­gitos decimales)"
#T218="Latitude (xxx.xxxx or -xxx.xxxx)"
T218="Latitud (xxx.xxxx o -xxx.xxxx)"
#T219="Longitude (xxx.xxxx or -xxx.xxxx)"
T219="Longitud (xxx.xxxx o -xxx.xxxx)"
#T220="Power"
T220="Poder"
#T221="Height"
T221="Altura"
#T222="Location"
T222="UbicaciÃ³n"
#T223="Description"
T223="DescripciÃ³n"



# tg_db.sh =============================
#T239="TG/Ref DB Management"
T239="GestiÃ³n de TG / Ref DB"

#T249="Push to DVSM/UC"
T249="Empuje a DVSM / UC"
#T250="PUSH (Favorite DB + Global DB)"
T250="PUSH (DB global favorito)"
#T251="Make sure you read <...success> on DVSM/UC"
T251="AsegÃºrese de leer <... Ã©xito> en DVSM / UC"
#T252="Reset Favorite DB"
T252="Restablecer base de datos favorita"
#T253="Favorite TG/Ref will be initialized."
T253="Se inicializarÃ¡ el TG / Ref favorito."
#T254="After resetting, it will push files to DVSM/UC"
T254="DespuÃ©s de reiniciar, enviarÃ¡ archivos a DVSM / UC"


# adhoc_basic.sh ===========================
#T260="BASIC Macro Configuration"
T260="ConfiguraciÃ³n de macro BÃSICA"
#T261="You are using BASIC Macro Configuration"
T261="EstÃ¡ utilizando la configuraciÃ³n de macro BÃSICA"
#T262="Do you want to change to Advanced Macro Configuration?"
T262="Â¿Quiere cambiar a la configuraciÃ³n avanzada de macros?"
#T263="All macro files were changed to the Advanced macro."
T263="Todos los archivos de macro se cambiaron a la macro avanzada."
#T264="DVSwitch services were restarted."
T264="Se reiniciaron los servicios de DVSwitch."


# adhoc_adv.sh =============================
#T270="<ADVANCED>"
T270="<AVANZADO>"
#T273="To apply editing, <Restart DVSwitch>"
T273="Para aplicar la ediciÃ³n, <Reiniciar DVSwitch>"
#T274="<ADVANCED Macro>"
T274="<Macro AVANZADA>"
#T275="Restart DVSwitch Services"
T275="Reinicie los servicios DVSwitch"
#T276="Change to <BASIC> dvsm.macro"
T276="Cambie a <BASIC> dvsm.macro"
#T277="Back to Advanced Configuration Menu"
T277="Volver al menÃº de configuraciÃ³n avanzada"
#T278="All macro files were changed back to the basic which is DVSwitch default macro."
T278="Todos los archivos de macro se cambiaron de nuevo al bÃ¡sico, que es el macro predeterminado de DVSwitch."


# adnl_dmr.sh =================================
#T280="Choose DMRPlus server"
T280="Elija el servidor DMRPlus"
#T282="IP or DNS of TGIF Server"
T282="IP o DNS del servidor TGIF"
#T283="Password of TGIF Server"
T283="ContraseÃ±a del servidor TGIF"
#T284="Port of TGIF Server"
T284="Puerto del servidor TGIF"
#T286="Name of other Network (no space)"
T286="Nombre de otra red (sin espacio)"
#T287="IP or DNS of other Network Server"
T287="IP o DNS de otro servidor de red"
#T288="Password of other Network Server"
T288="ContraseÃ±a de otro servidor de red"
#T289="Port of other Network Server"
T289="Puerto de otro servidor de red"


# Tools_menu.sh ===============================
#T300="Tools Menu"
T300="MenÃº de herramientas"
#T301="Clone RPi SD Card"
T301="Clonar tarjeta SD RPi"
#T302="Clone SD Card to a new one"
T302="Clonar la tarjeta SD a una nueva"
#T303="Configure ini. files"
T303="Configure ini. "
#T304="Analog_Bridge.ini, MMDVM_Bridge.ini... Files"        ; Keep the length same or shorter
T304="Analog_Bridge.ini, MMDVM_Bridge.ini ... Archivos"
#T305="Update & Upgrade"
T305="Actualizar"
#T306="Update & Upgrade"
T306="Actualizar"
#T307="Language"
T307="Idioma"
#T308="Select Language for DVSwitch Menus"
T308="Seleccionar idioma para los menÃºs de DVSwitch"

#T311="Restart DVSwitch Services"
T311="Reinicie los servicios DVSwitch"
#T312="Restart Analog & MMDVM Services (2sec)"
T312="Reiniciar analÃ³gico"
#T313="Reboot RPi Server"
T313="Reiniciar el servidor RPi"
#T314="Reboot Raspberry Pi Server (30sec)"
T314="Reiniciar el servidor Raspberry Pi (30 segundos)"
#T315="Shutdown RPi Server"
T315="Apagar el servidor RPi"
#T316="Shutdown Raspberry Pi"
T316="Apagar Raspberry Pi"
#T317="Back"
T317="atrÃ¡s"
#T318="Return to MAIN MENU"
T318="Volver al menÃº principal"

#T322="Show system information"
T322="Mostrar informaciÃ³n del sistema"

#T330="Temperature message"
T330="Mensaje de temperatura"
#T331="Enable/Disable temperature message"
T331="Activar / desactivar mensaje de temperatura"
#T332="Enable to send CPU temperature message"
T332="Habilitar para enviar mensaje de temperatura de la CPU"
#T333="Disable to send CPU temperature message"
T333="Desactivar para enviar mensaje de temperatura de la CPU"


# clone.sh ===================================
#T350="You can make a back-up or clone of the present installation."
T350="Puede hacer una copia de seguridad o una copia de la instalaciÃ³n actual."
#T351="- The new SD card can be same or smaller size card."
T351="- La nueva tarjeta SD puede ser de tamaÃ±o igual o menor."
#T352="- Use formatted/clean SD card."
T352="- Utilice una tarjeta SD formateada / limpia."
#T353="To start cloning, plug USB card reader into the Pi, with SD card."
T353="Para comenzar a clonar, conecte el lector de tarjetas USB al Pi, con la tarjeta SD."
#T354="You need to check the device first whether it is recognized by Pi."
T354="Primero debe verificar si el dispositivo lo reconoce Pi."
#T355="<Yes> to start checking device, <No> to Cancel"
T355="<SÃ­> para comenzar a verificar el dispositivo, <No> para cancelar"
#T356="Re-cloning onto the same SD card takes about 1 min."
T356="Volver a clonar en la misma tarjeta SD tarda aproximadamente 1 minuto."

#T360="Destination Drive"
T360="Unidad de destino"
#T361="Do you want to start cloning?"
T361="Â¿Quieres empezar a clonar?"

#T363="There is no storage device(s) in the Pi."
T363="No hay dispositivo (s) de almacenamiento en el Pi."
#T364="Please check the USB card reader and/or SD card."
T364="Compruebe el lector de tarjetas USB y / o la tarjeta SD."

#T365="During the process, you will be asked three times:"
T365="Durante el proceso, se le preguntarÃ¡ tres veces:"
#T366="1. First, ask for reformatting (initializing), type <yes>"
T366="1. Primero, solicite reformatear (inicializar), escriba <sÃ­>"
#T367="2. Second, enter file label, just press <Enter>"
T367="2. En segundo lugar, ingrese la etiqueta del archivo, simplemente presione <Intro>"
#T368="3. Finally, hit the <Enter> to finalize (unmount)."
T368="3. Finalmente, presione <Enter> para finalizar (desmontar)."


# update_upgrade.sh ===========================
#T380="This will check for available package upgrades."
T380="Esto buscarÃ¡ actualizaciones de paquetes disponibles."
#T381="Followings are upgradable"
T381="Los siguientes son actualizables"
#T382="apt-get update and check for upgrade"
T382="apt-get update y comprobar si hay actualizaciÃ³n"
#T383="There are no packages to upgrade."
T383="No hay paquetes para actualizar."
#T386="Total number of packages to upgrade :"
T386="NÃºmero total de paquetes para actualizar:"
#T387="Number of packages for DVSwitch :"
T387="NÃºmero de paquetes para DVSwitch:"
#T388="Number of packages for system and others :"
T388="NÃºmero de paquetes para el sistema y otros:"
#T390="<Yes> to upgrade, <No> to cancel"
T390="<SÃ­> para actualizar, <No> para cancelar"
#T392="update & upgrade was completed."
T392="actualizar"
#T393="DVSwitch Services will restart."
T393="Los servicios DVSwitch se reiniciarÃ¡n."
#T394="DVSwitch Services Restarting"
T394="Reinicio de los servicios DVSwitch"


# adnl_dmr.sh =================================
#T400="DMR Networks"
T400="Redes DMR"
#T401="DMRPlus Network"
T401="Red DMRPlus"
#T402="TGIF Network"
T402="Red TGIF"
#T403="Other1 Network"
T403="Otro1 Red"
#T404="Other2 Network"
T404="Other2 Network"
#T405="Brandmeister Network"
T405="Brandmeister Network"

#T406="Current Setup"
T406="ConfiguraciÃ³n actual"
#T407="Network name"
T407="Nombre de red"
#T408="Server address"
T408="DirecciÃ³n del servidor"
#T409="Password"
T409="ContraseÃ±a"
#T410="Port" T410="USRP Port? (Recommand: 50000~55000, None: default)"
T410="USRP Port? (Recommand: 50000~55000, None: default)"
#T411="Select for Default Network"
T411="Seleccionar para Red predeterminada"
#T412="Set this Network as a Default Server for DMR?"
T412="Â¿Configurar esta red como servidor predeterminado para DMR?"
#T413="Default"
T413="Default"
#T415="Do you want to change the setup?"
T415="Â¿Quieres cambiar la configuraciÃ³n?"
#T416="Do you want to set the network?"
T416="Â¿Quieres configurar la red?"
#T417="Change Default DMR Server"
T417="Cambiar el servidor DMR predeterminado"
#T418="Configure DMR Server"
T418="Configurar el servidor DMR"
#T419="Current Server"
T419="Servidor actual"
#T420="There is no configured DMR Network"
T420="No hay una red DMR configurada"
#T421="is default DMR Server."       # There is a subject before the sentence.
T421="es el servidor DMR predeterminado."
#T422="You can't delete it."
T422="No puedes borrarlo."
#T423="There is no configured DMR Network."
T423="No hay una red DMR configurada."


# Spaces =====================================
sp01=" "
sp02="  "
sp03="   "
sp04="    "
sp05="     "
sp06="      "
sp07="       "
sp08="        "
sp09="         "
sp10="          "
sp11="           "
sp12="            "
sp13="             "
sp14="              "
sp15="               "
sp16="                "
sp17="                 "
sp18="                  "
sp19="                   "
sp20="                    "
sp21="                     "
sp22="                      "
sp23="                       "
sp24="                        "
sp25="                         "
sp26="                          "
sp27="                           "
sp28="                            "
sp29="                             "
sp30="                              "

EOF
##
sudo cat > /var/lib/dvswitch/dvs/lan/english.txt <<- "EOF"
#=====================================================================================================#
#                                                                                                     #
# Language file for the scripts.                                                                      #
#                                                                                                     #
# Translate and change words only in the quotation marks                                              #
# If there is a number inside quotation mark, leave it as it is.                                      #
# Some words and phrases are easy enough for non-English speaking people to understand.               #
# If you don't think you need to translate some words or phrases, Just leave them in English.         #
# The length of the line can be a bit longer, about 5 more characters                                 #
# Please don't worry too much about the length or format. We will check them to suit to the scripts.  #
#                                                                                                     #
#=====================================================================================================#


#LN="EN"   ; Change the value of <LN> with 2-digit character, like "EN" "ES" or "FR"
LN="EN"
#language="English"    ; Your language in English, like French, German, Chinese
language="English"
#language_your_alphabet="English"    ; How to write your language in your alphabet, like Deutsch.... 
language_your_alphabet="English"

menu_translator=""
doc_translator=""
lan_ver=""


# General ================================
#T000="You are already using ISO639"     ; Change ISO639 to your language in your alphabet 
T000="You are already using English"
#T001="SAVE"
T001="SAVE"
#T002="CANCEL"
T002="CANCEL"
#T003="Finished"
T003="Finished"
#T004="<Enter> to MENU"
T004="<Enter> to MENU"
#T005="<Yes> to Continue, <No> to Cancel"
T005="<Yes> to Continue, <No> to Cancel"
#T006="Please WAIT"
T006="Please WAIT"
#T007="Edit"
T007="Edit"
#T008="Press <ENTER> to continue"
T008="Press <ENTER> to continue"
#T009="Input"
T009="Input"


# dvs ====================================
#T010="MAIN MENU"
T010="MAIN MENU"
#T011="Initial Configuration"
T011="Initial Configuration"
#T012="Enter Callsign, DMR ID, BM Server and AMBE"
T012="Enter Callsign, DMR ID, BM Server and AMBE"
#T013="Advanced Configuration"
T013="Advanced Configuration"
#T014="TG/Ref Manage, Macro, DMR Networks"
T014="TG/Ref Manage, Macro, DMR Networks"
#T015="Tools"
T015="Tools"
#T016="SD Card Clone, Upgrade, Language, Reboot/Shutdown"   ; Keep the length same or shorter
T016="SD Card Clone, Upgrade, Language, Reboot/Shutdown"
#T017="Credits"
T017="Credits"
#T018="Credits of DVSwitch and Menu Scripts"
T018="Credits of DVSwitch and Menu Scripts"
#T019="Exit"
T019="Exit"
#T020="Exit DVSwitch Menu"
T020="Exit DVSwitch Menu"
#T023="Select TG List"
T023="Select TG List"
#T024="FreeDMR / BM"
T024="FreeDMR / BM"


# dvsb====================================
#T025="Configuration for Prerequisite Items"
T025="Configuration for Prerequisite Items"
#T026="Configure prerequisite items for DVSwitch."
T026="Configure prerequisite items for DVSwitch."
#T029="Working"       ; the work is in progress
T029="Working"


# Contents of Credits
#T030="DVSwitch : Mike N4IRR and Steve N4IRS"
T030="DVSwitch : Mike N4IRR and Steve N4IRS"
#T031="Menu Script and Macro : HL5KY"
T031="Menu Script and Macro : HL5KY"
#T032="English Documentation : W8RIK and K2KXK"
T032="English Documentation : W8RIK and K2KXK"
#T033="Menu Script Translation :"
T033="Menu Script Translation :"
#T034="ISO639 Documentation : "        ; Change ISO639 to your language in your alphabet 
T034="ISO639 Documentation : "
#T035="Dashboard : SP2ONG"
T035="Dashboard : SP2ONG"

# init_config.sh =========================
#T150="Previous Configuration notice"
T150="Previous Configuration notice"
#T151="You already have a previous configuration :"
T151="You already have a previous configuration :"
#T152="Ad Hoc menu & macros will be updated/initialized and changes will be lost."
T152="Ad Hoc menu & macros will be updated/initialized and changes will be lost."

#T154="Initial Configuration"
T154="Initial Configuration"
#T155="This process will ask you Callsign, DMR ID, USRP port, Hardware AMBE.... for ini. files."
T155="This process will ask you Callsign, DMR ID, USRP port, Hardware AMBE.... for ini. files."
#T160="Callsign? (case-insensitive)"
T160="Callsign? (case-insensitive)"
#T161="NXDN ID? (Enter for none)"
T161="NXDN ID? (Enter for none)"
#T162="password for Brandmeister (Enter if not changed)"
T162="Enter your personalized hotspot password configured via Brandmeister SelfCare, if applicable, otherwise leave as default."
#T163="Choose your local BM Server"
T163="Choose your local BM Server"

#T165="CCS7/DMR ID should be 7 digits"
T165="CCS7/DMR ID should be 7 digits"
#T166="2 digit number"
T166="2 digit number"
#T167="should be 9 digits"
T167="should be 9 digits"
#T168="460800 (old version: 230400)"
T168="460800 (old version: 230400)"

#T170="Hardware Vocoder (AMBE)"
T170="Hardware Vocoder (AMBE)"
#T171="1 AMBE Server"
T171="1 AMBE Server"
#T172="External AMBE Server e.g., ZumAMBE Server"       ; Keep the length same or shorter
T172="External AMBE Server e.g., ZumAMBE Server"
#T173="2 USB Type AMBE"
T173="2 USB Type AMBE"
#T174="ThumbDV, DVstick"
T174="ThumbDV, DVstick"
#T175="3 GPIO type AMBE"
T175="3 GPIO type AMBE"
#T176="DV3000 or PAMBE Board"
T176="DV3000 or PAMBE Board"
#T177="4 No Hardware Vocoder"
T177="4 No Hardware Vocoder"
#T178="Use Software Vocoder"
T178="Use Software Vocoder"

#T180="Input Finished"
T180="Input Finished"
#T181="Input for Initial Configuration Finished."
T181="Input for Initial Configuration Finished."
#T182="ini files' Configuration will start."
T182="ini files' Configuration will start."
#T185="Processing Initial Configuration"
T185="Processing Initial Configuration"

#T190="Initial Configuration Finished"
T190="Initial Configuration Finished"
#T191="You can start using DVSwitch after REBOOTing"
T191="You can start using DVSwitch after REBOOTing"
#T192="System will REBOOT and SSH will be disconnected."
T192="System will REBOOT and SSH will be disconnected."
#T193="<Yes> to REBOOT, or <No> back to MENU"
T193="<Yes> to REBOOT, or <No> back to MENU"
#T194="DVSwitch Server is up and running"
T194="DVSwitch Server is up and running"
#T195="Press <ENTER> to finish Configuration"
T195="Press <ENTER> to finish Configuration"


# adv_config_menu.sh =============================
#T200="Advanced Configuration Menu"
T200="Advanced Configuration Menu"
#T201="Configure Favorite TG/Ref"
T201="Configure Favorite TG/Ref"
#T202="Edit Favorite TGs and Reflectors, Push to DVSM/UC"     ; Keep the length same or shorter
T202="Edit Favorite TGs and Reflectors, Push to DVSM/UC"
#T203="Ad Hoc Menu & Macro"
T203="Ad Hoc Menu & Macro"
#T204="Managing Ad Hoc Menu and Macro"
T204="Managing Ad Hoc Menu and Macro"
#T205="Additional DMR Networks"
T205="Additional DMR Networks"
#T206="Setup for DMRPlus, TGIF and other Networks"
T206="Setup for DMRPlus, TGIF and other Networks"
#T207="Back"
T207="Back"
#T208="Return to MAIN MENU"
T208="Return to MAIN MENU"
#T209="Configure other stanzas"
T209="Configure other stanzas"
#T210="Freq, Pwr, Lat, Long, Location ...."
T210="Freq, Pwr, Lat, Long, Location ...."


# config_ini.sh ============================
#T211="Configure ini. files"
T211="Configure ini. files"


# config_other_stz.sh ============================
#T213="RX Frequency (xxx.xxxx MHz)"
T213="RX Frequency (xxx.xxxx MHz)"
#T214="TX Frequency (xxx.xxxx MHz)"
T214="TX Frequency (xxx.xxxx MHz)"
#T215="This process will ask you the parameters in [Info] section of MMDVM_Bridge.ini"
T215="This process will ask you the parameters in [Info] section of MMDVM_Bridge.ini"
#T216="RX Frequency (xxx.xxxx MHz, with 4 decimal digits)"
T216="RX Frequency (xxx.xxxx MHz, with 4 decimal digits)"
#T217="TX Frequency (xxx.xxxx MHz, with 4 decimal digits)"
T217="TX Frequency (xxx.xxxx MHz, with 4 decimal digits)"
#T218="Latitude (xxx.xxxx or -xxx.xxxx)"
T218="Latitude (xxx.xxxx or -xxx.xxxx)"
#T219="Longitude (xxx.xxxx or -xxx.xxxx)"
T219="Longitude (xxx.xxxx or -xxx.xxxx)"
#T220="Power"
T220="Power"
#T221="Height"
T221="Height"
#T222="Location"
T222="Location"
#T223="Description"
T223="Description"


# tg_db.sh =============================
#T239="TG/Ref DB Management"
T239="TG/Ref DB Management"
#T249="Push to DVSM/UC"
T249="Push to DVSM/UC"
#T250="PUSH (Favorite DB + Global DB)"
T250="PUSH (Favorite DB + Global DB)"
#T251="Make sure you read <...success> on DVSM/UC"
T251="Make sure you read <...success> on DVSM/UC"
#T252="Reset Favorite DB"
T252="Reset Favorite DB"
#T253="Favorite TG/Ref will be initialized."
T253="Favorite TG/Ref will be initialized."
#T254="After resetting, it will push files to DVSM/UC"
T254="After resetting, it will push files to DVSM/UC"


# adhoc_basic.sh ===========================
#T260="BASIC Macro Configuration"
T260="BASIC Macro Configuration"
#T261="You are using BASIC Macro Configuration"
T261="You are using BASIC Macro Configuration"
#T262="Do you want to change to Advanced Macro Configuration?"
T262="Do you want to change to Advanced Macro Configuration?"
#T263="All macro files were changed to the Advanced macro."
T263="All macro files were changed to the Advanced macro."
#T264="DVSwitch services were restarted."
T264="DVSwitch services were restarted."


# adhoc_adv.sh =============================
#T270="<ADVANCED>"
T270="<ADVANCED>"
#T273="To apply editing, <Restart DVSwitch>"
T273="To apply editing, <Restart DVSwitch>"
#T274="<ADVANCED Macro>"
T274="<ADVANCED Macro>"
#T275="Restart DVSwitch Services"
T275="Restart DVSwitch Services"
#T276="Change to <BASIC> dvsm.macro"
T276="Change to <BASIC> dvsm.macro"
#T277="Back to Advanced Configuration Menu"
T277="Back to Advanced Configuration Menu"
#T278="All macro files were changed back to the basic which is DVSwitch default macro."
T278="All macro files were changed back to the basic which is DVSwitch default macro."


# adnl_dmr.sh =================================
#T280="Choose DMRPlus server"
T280="Choose DMRPlus server"
#T282="IP or DNS of TGIF Server"
T282="IP or DNS of TGIF Server"
#T283="Password of TGIF Server"
T283="Password of TGIF Server"
#T284="Port of TGIF Server"
T284="Port of TGIF Server"
#T286="Name of other Network (no space)"
T286="Name of other Network (no space)"
#T287="IP or DNS of other Networks"
T287="IP or DNS of other Networks"
#T288="Password of other Networks"
T288="Password of other Networks"
#T289="Port of other Networks"
T289="Port of other Networks"


# Tools_menu.sh ===============================
#T300="Tools Menu"
T300="Tools Menu"
#T301="Clone RPi SD Card"
T301="Clone RPi SD Card"
#T302="Clone SD Card to a new one"
T302="Clone SD Card to a new one"
#T303="Configure ini. files"
T303="Configure ini. files"
#T304="Analog_Bridge.ini, MMDVM_Bridge.ini... Files"        ; Keep the length same or shorter
T304="Analog_Bridge.ini, MMDVM_Bridge.ini... Files"
#T305="Update & Upgrade"
T305="Update & Upgrade"
#T306="Update & Upgrade"
T306="Update & Upgrade"
#T307="Language"
T307="Language"
#T308="Select Language for DVSwitch Menus"
T308="Select Language for DVSwitch Menus"

#T311="Restart DVSwitch Services"
T311="Restart DVSwitch Services"
#T312="Restart Analog & MMDVM Services (2sec)"
T312="Restart Analog & MMDVM Services (2sec)"
#T313="Reboot RPi Server"
T313="Reboot RPi Server"
#T314="Reboot Raspberry Pi Server (30sec)"
T314="Reboot Raspberry Pi Server (30sec)"
#T315="Shutdown RPi Server"
T315="Shutdown RPi Server"
#T316="Shutdown Raspberry Pi"
T316="Shutdown Raspberry Pi"
#T317="Back"
T317="Back"
#T318="Return to MAIN MENU"
T318="Return to MAIN MENU"

#T322="Show system information"
T322="Show system information"

#T330="Temperature message"
T330="Temperature message"
#T331="Enable/Disable temperature message"
T331="Enable/Disable temperature message"
#T332="Enable to send CPU temperature message"
T332="Enable to send CPU temperature message"
#T333="Disable to send CPU temperature message"
T333="Disable to send CPU temperature message"


# clone.sh ===================================
#T350="You can make a back-up or clone of the present installation."
T350="You can make a back-up or clone of the present installation."
#T351="- The new SD card can be same or smaller size card."
T351="- The new SD card can be same or smaller size card."
#T352="- Use formatted/clean SD card."
T352="- Use formatted/clean SD card."
#T353="To start cloning, plug USB card reader into the Pi, with SD card."
T353="To start cloning, plug USB card reader into the Pi, with SD card."
#T354="You need to check the device first whether it is recognized by Pi."
T354="You need to check the device first whether it is recognized by Pi."
#T355="<Yes> to start checking device, <No> to Cancel"
T355="<Yes> to start checking device, <No> to Cancel"
#T356="Re-cloning onto the same SD card takes about 1 min."
T356="Re-cloning onto the same SD card takes about 1 min."

#T360="Destination Drive"
T360="Destination Drive"
#T361="Do you want to start cloning?"
T361="Do you want to start cloning?"

#T363="There is no storage device(s) in the Pi."
T363="There is no storage device(s) in the Pi."
#T364="Please check the USB card reader and/or SD card."
T364="Please check the USB card reader and/or SD card."

#T365="During the process, you will be asked three times:"
T365="During the process, you will be asked three times:"
#T366="1. First, ask for reformatting (initializing), type <yes>"
T366="1. First, ask for reformatting (initializing), type <yes>"
#T367="2. Second, enter file label, just press <Enter>"
T367="2. Second, enter file label, just press <Enter>"
#T368="3. Finally, hit the <Enter> to finalize (unmount)."
T368="3. Finally, hit the <Enter> to finalize (unmount)."


# update_upgrade.sh ===========================
#T380="This will check for available package upgrades."
T380="This will check for available package upgrades."
#T381="Followings are upgradable"
T381="Followings are upgradable"
#T382="apt-get update and check for upgrade"
T382="apt-get update and check for upgrade"
#T383="There are no packages to upgrade."
T383="There are no packages to upgrade."
#T386="Total number of packages to upgrade :"
T386="Total number of packages to upgrade :"
#T387="Number of packages for DVSwitch :"
T387="Number of packages for DVSwitch :"
#T388="Number of packages for system and others :"
T388="Number of packages for system and others :"
#T390="<Yes> to upgrade, <No> to cancel"
T390="<Yes> to upgrade, <No> to cancel"
#T392="update & upgrade was completed."
T392="update & upgrade was completed."
#T393="DVSwitch Services will restart."
T393="DVSwitch Services will restart."
#T394="DVSwitch Services Restarting"
T394="DVSwitch Services Restarting"


# adnl_dmr.sh =================================
#T400="DMR Networks"
T400="DMR Networks"
#T401="DMRPlus Network"
T401="DMRPlus Network"
#T402="TGIF Network"
T402="TGIF Network"
#T403="Other1 Network"
T403="Other1 Network"
#T404="Other2 Network"
T404="Other2 Network"
#T405="Brandmeister Network"
T405="Brandmeister Network"

#T406="Current Setup"
T406="Current Setup"
#T407="Network name"
T407="Network name"
#T408="Server address"
T408="Server address"
#T409="Password"
T409="Password"
#T410="USRP Port? (Recommand: 50000~55000, None: default)"
T410="USRP Port? (Recommand: 50000~55000, None: default)"
#T411="Select for Default Network"
T411="Select for Default Network"
#T412="Set this Network as a Default Server for DMR?"
T412="Set this Network as a Default Server for DMR?"
#T413="default"
T413="default"

#T415="Do you want to change the setup?"
T415="Do you want to change the setup?"
#T416="Do you want to set the network?"
T416="Do you want to set the network?"
#T417="Change Default DMR Server"
T417="Change Default DMR Server"
#T418="Configure DMR Server"
T418="Configure DMR Server"
#T419="Current Server"
T419="Current Server"
#T420="There is no configured DMR Network"
T420="There is no configured DMR Network"
#T421="is default DMR Server."       # There is a subject before the sentence.
T421="is default DMR Server."
#T422="You can't delete it."
T422="You can't delete it."
#T423="There is no configured DMR Network."
T423="There is no configured DMR Network."


# Spaces =====================================
sp01=" "
sp02="  "
sp03="   "
sp04="    "
sp05="     "
sp06="      "
sp07="       "
sp08="        "
sp09="         "
sp10="          "
sp11="           "
sp12="            "
sp13="             "
sp14="              "
sp15="               "
sp16="                "
sp17="                 "
sp18="                  "
sp19="                   "
sp20="                    "
sp21="                     "
sp22="                      "
sp23="                       "
sp24="                        "
sp25="                         "
sp26="                          "
sp27="                           "
sp28="                            "
sp29="                             "
sp30="                              "

EOF
###


