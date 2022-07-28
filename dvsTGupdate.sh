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
sh -c "$(curl -fsSL https://github.com/hp3icc/DVSwitch-Mobile-TG-List/raw/main/lang.sh)"
###


