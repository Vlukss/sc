#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
export NC="\e[0m"
export YELLOW='\033[0;33m';
export RED="\033[0;31m"               
###########- END COLOR CODE -##########
tram=$( free -h | awk 'NR==2 {print $2}' )
uram=$( free -h | awk 'NR==2 {print $3}' )
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )


BURIQ () {
    curl -sS https://raw.githubusercontent.com/Vlukss/permission/main/ipmini > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/Vlukss/permission/main/ipmini | grep $MYIP | awk '{print $2}')
Isadmin=$(curl -sS https://raw.githubusercontent.com/Vlukss/permission/main/ipmini | grep $MYIP | awk '{print $5}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/Vlukss/permission/main/ipmini | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}

x="ok"


PERMISSION

if [ "$res" = "Expired" ]; then
Exp="\e[36mExpired\033[0m"
rm -f /home/needupdate > /dev/null 2>&1
else
Exp=$(curl -sS https://raw.githubusercontent.com/Vlukss/permission/main/ipmini | grep $MYIP | awk '{print $3}')
fi
export RED='\033[0;31m'
export GREEN='\033[0;32m'

# // SSH Websocket Proxy
ssh_ws=$( systemctl status ws-stunnel | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    status_ws="${GREEN}ON${NC}"
else
    status_ws="${RED}OFF${NC}"
fi

# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="${GREEN}ON${NC}"
else
    status_nginx="${RED}OFF${NC}"
fi

# // SSH Websocket Proxy
xray=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $xray == "running" ]]; then
    status_xray="${GREEN}ON${NC}"
else
    status_xray="${RED}OFF${NC}"
fi

GREEN='\033[0;32m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
yl='\e[32;1m'
bl='\e[36;1m'
gl='\e[32;1m'
rd='\e[31;1m'
mg='\e[0;95m'
blu='\e[34m'
op='\e[35m'
or='\033[1;33m'
bd='\e[1m'
color1='\e[031;1m'
color2='\e[34;1m'
color3='\e[0m'
clear

echo -e ""
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
DOMAIN=$(cat /etc/xray/domain)
MYIP=$(curl -s ipinfo.io/ip )
CITY=$(curl -s ipinfo.io/city )
up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')
tram=$( free -m | awk 'NR==2 {print $2}' )
echo -e ""
echo -e "\033[0;34m╒═════════════════════════════════════════════════════════════╕
      ${NC}Welcome To ${GREEN}Vluks Store ${NC}Script installer ${GREEN}( Pro Edition )
         ${NC} This Script Coded on Bash & Python Language
        This Will Quick Setup VPN Server On Your Server
                   Owner : ${GREEN} Wak Vluks
             ${NC}Copyright © By: Vluks (2022-2033)
${yl}
 =============(Script Auto instal: Wak Vluks)=============="
echo -e "\033[0;34m╒═════════════════════════════════════════════════════════════╕\033[0m${NC}"
echo -e " \E[41;1;39m                     ⇱ INFORMASI VPS ⇲                       \E[0m"
echo -e "\033[0;34m╘═════════════════════════════════════════════════════════════╛\033[0m${NC}"
if [ "$Isadmin" = "ON" ]; then
uis="${GREEN}Premium User$NC"
else
uis="${RED}Free Version$NC"
fi
echo -e "  ✪$bd User Rules        ${color1} •${color3}$bd $uis"
echo -e "  ✪$bd ISP Name          ${color1} •${color3}$bd $ISP"
echo -e "  ✪$bd City              ${color1} •${color3}$bd $CITY"
echo -e "  ✪$bd Total RAM         ${color1} •${yl}$bd $tram MB${NC}"
echo -e "  ✪$bd IP VPS            ${color1} •${color3}$bd $MYIP"
echo -e "  ✪$bd DOMAIN VPS        ${color1} •${CYAN}$bd $DOMAIN${NC}"
echo -e "  ✪$bd Waktu Aktif       ${color1} •${or}$bd $up${NC}"
echo -e "  ✪$bd Client Name       ${color1} •${color3}$bd $Name"

DATE=$(date +'%d %B %Y')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "  ✪$bd Expiry script     ${color1} • $(( (d1 - d2) / 86400 )) Days"
}
mai="datediff "$Exp" "$DATE""
if [ $exp \> 1000 ];
then
    echo -e "  ✪$bd Expiry script     ${color1} • $(( (d1 - d2) / 86400 )) Days"
else
    datediff "$Exp" "$DATE"
fi;
echo -e "\033[0;34m╒═════════════════════════════════════════════════════════════╕\033[0m${NC}"
echo -e " \E[41;1;39m                     ⇱ MENU PANEL VPS ⇲                      \E[0m"
echo -e "\033[0;34m╘═════════════════════════════════════════════════════════════╛\033[0m${NC}"
echo -e "[${GREEN}01${NC}]${color1} •${color3}$bd PANEL SSH & OpenVPN     [${GREEN}09${NC}]${color1} •${color3}$bd MENU SETTING [\033[1;32mPro${NC}]
[${GREEN}02${NC}]${color1} •${color3}$bd PANEL Vmess & Vless     [${GREEN}10${NC}]${color1} •${color3}$bd WEB MENU
[${GREEN}03${NC}]${color1} •${color3}$bd PANEL L2tp & PPTP       [${GREEN}11${NC}]${color1} •${color3}$bd INFO Script \033[1;36mVluks${NC}
[${GREEN}04${NC}]${color1} •${color3}$bd PANEL Wireguard         [${GREEN}12${NC}]${color1} •${color3}$bd Cek Bandwitch
[${GREEN}05${NC}]${color1} •${color3}$bd PANEL SSR & Shdsok      [${GREEN}13${NC}]${color1} •${color3}$bd Cek Bandwitch \033[1;33mHarian${NC}
[${GREEN}06${NC}]${color1} •${color3}$bd PANEL Tr GPR & GO       [${GREEN}14${NC}]${color1} •${color3}$bd Reboot VPS
[${GREEN}07${NC}]${color1} •${color3}$bd GANTI Port All Acount   [${GREEN}15${NC}]${color1} •${color3}$bd Restart VPS
[${GREEN}08${NC}]${color1} •${color3}$bd CEK Status \033[1;32mRUNNING${NC}      [${GREEN}00${NC}]${color1} •${color3}$bd \033[1;31mCEK AREK AKTIF${NC} \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m"
echo -e "\033[0;34m╒═════════════════════════════════════════════════════════════╕\033[0m${NC}"
echo -e " \E[41;1;39m                   ⇱ VLUKS STORE ⇲                   \E[0m"
echo -e "\033[0;34m╘═════════════════════════════════════════════════════════════╛\033[0m${NC}"
echo -e  ""
 read -p "  Select menu :  " menu
echo -e   ""
case $menu in
1)
ssh
;;
2)
v2raay
;;
3)
l2tp
;;
4)
wgr
;;
5)
ssssr
;;
6)
trojaan
;;
7)
changeport
;;
8)
running
;;
9)
menu-tools
;;
10)
wbmn
;;
11)
info
;;
12)
vnstat
;;
13)
vnstat -d
;;
14)
reboot
;;
15)
restart
;;
0 | 00)
cekssh
;;
*)
exit
;;
esac
