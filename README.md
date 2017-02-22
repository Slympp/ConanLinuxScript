# Conan Linux Script

## Description

Script made in order to make administration of a Conan Exiles server on Linux easy

Features are described in the Usage section.

Feel free to send your fixs/distro compatibilities/features by sending a pull request. 

| Distributions	| Versions		  | Status    |
|:-------------:|:---------------:|:---------:|
| Ubuntu      	| 16.04 *server*  | Supported |
| Ubuntu      	| 16.04 *desktop* | Supported |

Made by Slymp, for [Akylonia.net](http://akylonia.net "Akylonia website")

Add me on [Steam](http://steamcommunity.com/id/Slymp/ "Steam") or join us on [Discord](https://discordapp.com/invite/7zbWQzU "Discord")


## Usage

 * **start** : Start the server. Don't do anything if a server is running.

 * **stop** : Shutdown the server cleanly by sending a SIGINT to the screen.

 * **reboot [reason]** : Restart the server securely. You can specify a message to send with your Discord Bot.     
   *(i.e.: conan reboot "Quick reboot to flush memory leaks !")*

 * **update** : Check for available updates. If needed, close the server, apply the update and restart.

 * **show** : Display running server(s).

 * **screen** : Display the server console to look at your server logs. Use "**Ctrl + A**" then "**Ctrl + D**" to leave the screen without stopping the server.

 * **install** : Install the whole server and dependencies
    + Creates a specific user for running your server
    + Set up a minimal iptables configuration
    + Install wine 2.0, screen, steamCmd...
    + Download server files

 * **discord** : Install a Discord Bot that will handle handle communication between the script and your Discord server.      
 Announces:
 	+ Server start
 	+ Server stop
 	+ Delayed announce before server shutdown
 	+ Server updates
 	+ Server custom reboots
	+ RaidsHours ON/OFF

  *Admins may be able in the future to handle the server with commands on a specific channel*

 * **raidhours** : Enable a daily period where raids are possible. You need to configure the script and run "conan crontab"      
  *This will require a reboot of your server to apply the changements. Your players will be warned with a Discord message and a delay*

 * **crontab** : Enable crontabs to automate the management of your server.
 	+ auto-restarter: Restart your server if it crashs when you're not here to restart it.
 	+ auto-updater: Let the script handle updates for you.
 	+ raid hours: Automate the "raidhours" task.


******


# How-to-use

## Downloading & Configuration

Clone the repository containing the scripts, then change your current directory to where you have cloned the repository

	git clone https://github.com/Slympp/ConanLinuxScript && cd ConanLinuxScript

Open your favorite text editor to set up your parameters: ServerName, ports, paths, raids hours, the discord Bot...

	nano conan


## Server installation, need root privileges

Run the script. You will be asked to create a new user (or use an already existing one). For this installation, user will be "steam"

	sudo bash conan install


(Optional) Install the Discord bot. It will announce the shutdowns/updates/reboots

	sudo bash conan discord


Give permissions to your $user

	sudo chown steam:steam conan discord_bot.py


Move both bash and python script in the $user home

	cp conan discord_bot.py /home/steam/


Create a symbolic link to make your life easier (and crontabs working)

	sudo ln -s /home/steam/conan /usr/bin/conan


Installation is almost finished, you should now always use your user to interact with the script and your server.
If you're using a desktop version or ssh, disconnect from your session and login as $user (it's recommended in order to avoid errors with screen)


## Using the server, as $user

**You should always use your Conan Exiles specific user to interact with your server.**

(Recommended) Set up your crontabs

	./conan crontab


Start your server

	./conan start


Check that your server is running.

	./conan show


Look at the logs by attaching the screen. Detach with Ctrl + A + D

	./conan screen

Enjoy ! :D



## TODO :

* Send in game messages when RCON will be supported
* Optimize code
* Implement AvatarHours like RaidHours
* Watch if there is a need to backup before an update (seems not but well...)
* ... 


## Known issues

Error with "conan screen" : "Cannot open your terminal '/dev/pts/x' - please check."
* make sure you're current session is REALLY $user.
* try "script /dev/null"


## Changelog

Version 9
 + Tutorial updated
 + Cleaner output
 + Logs on crontab

Version 8
 + many fixs
 + stop: now wait that the PID is really killed before closing 
 + [NEW] "wait" parameter for start: Loop for 10mn trying to run a server if there's one currently running 
 + [NEW] raidhours: you need to configure a RaidHoursStart and RaidHoursDuration at the top of the script. It will reboot server and send a Discord message when needed

Version 7
 + User guide added
 + Server password handling removed (need to check this later)
 + Reboot command added

Version 6
 + Discord Bot announcer added
 + Fixed some prompts


## Thanks 

 + [discord.py](https://github.com/Rapptz/discord.py "discord.py")
 + [prom3theu5](https://github.com/prom3theu5/ConanExilesServerUpdater "prom3theu5")
 + [Untriel](http://steamcommunity.com/id/untriel "Untriel")
 + [Awful Citizen](http://steamcommunity.com/id/awfulcitizen "Awful Citizen")
