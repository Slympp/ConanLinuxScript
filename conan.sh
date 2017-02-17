#!/bin/sh

# Script made by Slymp for Akylonia.net
# Join us on discord.gg/7zbWQzU

ScriptVersion=1

# /Path/To/Folder
user=steam
ConanPath=/home/$user/ConanServer
SteamCmdPath=/home/$user/steamcmd
SteamPath=/home/$user/Steam

IP=37.59.45.211
Server_Name="[EU/FR] Akylonia.net | XP x2 | NoRules | Wipe 17.02"

# Leaves "" if you don't want to use a password
Server_Password=""

function start {

echo "Starting server..."

isServerDown=$(ps axf | grep ConanSandboxServer-Win64-Test.exe | grep -v grep)

if [ -z "$isServerDown" ];
then
	screen -dmS conan bash -c 'wine "$ConanPath/ConanSandboxServer.exe" "ConanSandbox?MULTIHOME=$IP?listen?" -log -ServerName=$Server_Name -ServerPassword=$Server_Password'
	echo "Server is now up"
	echo "Use \"conan screen\" to watch logs"
else
	echo "Server is already up, no restart required"
fi
}

function stop {

pid=$(ps axf | grep ConanSandboxServer-Win64-Test.exe | grep -v grep | awk '{print $1}')

echo "Existing PIDs: $pid"
# TODO: if pid != null + send rcon msg in game and sleep X mn when rcon support will be available
exec kill -SIGINT $pid

cpt=15
while [ $cpt -gt 0 ]; do
   echo "Shutting down... $cpt"
   sleep 1
   let cpt=cpt-1
done
echo "Server is now shutdown"
}

function update {

echo "Deleting appcache..."
rm -rf $SteamPath/appcache/

# Pull new info and compare new timestamp to saved timestamp
# You may need to initially run the command for currentTimestamp manually and redirect it to /home/steam/exiles/lastUpdate
echo "Checking for last update..."
currentTimestamp=$($SteamCmdPath/steamcmd.sh +login anonymous +app_info_update 1 +app_info_print 443030 +quit | grep -EA 1000 "^\s+\"branches\"$" | grep -EA 5 "^\s+\"public\"$" | grep -m 1 -EB 10 "^\s+}" | grep -E "^\s+\"timeupdated\"\s+" | tr '[:blank:]"' ' ' | awk '{print $2}')
lastTimestamp=$(cat $ConanPath/lastUpdate)

if [ $currentTimestamp -gt $lastTimestamp ];
then
	echo "[V] New update found"
        stop
	echo "Deleting appcache..."
	rm -rf $SteamPath/appcache/
	$SteamCmdPath/steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir $ConanPath +login anonymous +app_update 443030 validate +quit

	echo "Update finished"
        echo "$currentTimestamp" > $ConanPath/lastUpdate

	start
else
        echo "[X] No update found"
fi
}

function show {

exec screen -ls
}

function screen {

exec screen -r $1
}


# TODO: check if files are valides
function validate { 
echo "Not implemented yet"
}



# TODO: install the whole stuff
function install {

echo "Starting the installation"

echo "Creating user"
#if [ $user == empty ]
	# echo "Please enter a name for your Conan Exiles user. You can provide an existing user"
        # Ask to enter user=;
#fi

#if [ $user does not exist]
#then
	#adduser $user
	#passwd $user
#else

#su - $user

echo "Setting up iptables..."
#TODO: Move la gestion du port dans le script

#iptables -t filter -I INPUT -p udp --dport 7777 -j ACCEPT
#iptables -t filter -I INPUT -p udp --dport 7778 -j ACCEPT
#iptables -t filter -I INPUT -p udp --dport 27015 -j ACCEPT


echo "Installing wine 2.0..."
#sudo add-apt-repository ppa:ricotz/unstable
#sudo apt remove wine wine1.8 wine-stable libwine* fonts-wine* && sudo apt autoremove
#sudo apt update
#sudo apt install wine2.0

echo "Installing SteamCMD"
# if [ $SteamCmdPath == empty ]
	# echo "Please enter a path. If you already have a linux version of SteamCMD, you can provide its path"
        # Ask to enter SteamCmdPath=;
#fi

# if $SteamCmdPath directory OR $SteamCmdPath/steamcmd.sh file doesn't not exist on disk
#then
	echo "$SteamCmdPath seems not to be a valid installation. Do you want to install SteamCMD ? [y/N]"
	#if [N]
		#then
		echo "Exiting installation..."
		#exit 1
	#else
		#mkdir $SteamCmdPath && cd $SteamCmdPath
		echo "Downloading SteamCMD..."
        	#wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
       		#tar -xvzf steamcmd_linux.tar.gz
       		#rm -rf steamcmd_linux.tar.gz
		#steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir $ConanPath +login anonymous +app_update 443030 validate +quit
#fi

echo "Downloading lastest version of Conan Exiles Server"
#steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir $ConanPath +login anonymous +app_update 443030 validate +quit

echo "Your Conan Exiles is now fully installed. You can use \"conan start\" to run it"

echo -e "Do you want to add crontabs in order to automate restarts and Steam updates ? [y/N]"

#if [N]
#then
	#exit 1
#else
	#echo "Verify that your server is online and start it if it's not. Enter a number of minutes between checks (or 0 to skip)"
	#if [ ret == empty ]
	#then
		#ret=5
	#fi

	#if [ ret != 0 ]
	#then
		#crontab -l > tmp_cron
		#echo */$ret * * * * conan start
	#fi

	#echo "Verify that your server is up-to-date and update it if it's not. Enter a number of minutes between checks (or 0 to skip)"
        #if [ ret == empty ]
	#then
		#ret=10

	#fi

	#if [ ret != 0]
        #then
                #crontab -l > tmp_cron
                #echo */$ret * * * * conan update
        #fi
#fi
}

function indent { sed -e 's/^/\t/'; }

function help {

echo "Script with tools for running a Conan Exiles server on Linux"
echo "Made for Ubuntu 16.04, by Slymp (http://akylonia.net)"

echo ""

echo "Available commands:"
echo -e "start\t\t: Starts server. Checks for servers already running" | indent
echo -e "stop\t\t: Stops safely servers by sending a SIGINT" | indent
echo -e "update\t\t: Apply a pending update. Closes and restarts the servers properly" | indent
echo -e "show\t\t: Display running servers and their id" | indent
echo -e "screen [id]\t: Display console. Use \"Ctrl + A D\" to quit the screen without stopping the server" | indent
echo ""
echo -e "[!] Be careful, leaving a screen with Ctrl + C force your server to crash without saving, which can heavily corrupt your database (empty boxes at each restart, crashes, XP losses).\n" | indent
echo -e "If it happens, look at your game_backup_<id>.db files in \"$ConanPath/ConanSandbox/Saved/\", find a backup that precedes the crash and use \"mv game_backup_<id>.db game.db\"" | indent
}

case "$1" in
    start) start ;;
    stop) stop ;;
    update) update ;;
    show) show ;;
    screen) screen ;;
    help) help ;;
    install) install ;;
    validate) validate ;;

    *) echo "Command not found: $1. Use \"conan help\" to get more informations" ;;
esac
