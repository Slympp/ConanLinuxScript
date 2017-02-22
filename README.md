# Conan Linux Script

Made by Slymp, with and for the Conan Exiles community

 * start (wait): Start server. Close if a server is running. With "conan start wait", it will looping to try to start a server for 10mn
 * stop: Safely stop servers by sending a SIGINT
 * reboot [reason]: Reboot the server safely and send a message to Discord.
 * update: Apply a pending update. Closes and restarts the servers properly
 * show: Display running servers and their id
 * screen [id]: Display console. Use "Ctrl + A D" to quit the screen without stopping the server
 * install: Installs the whole stuff
     * creates specific user
     * set up basic iptables
     * install screen, wine 2.0, steamCmd
     * download server files
 * crontab: Allows to enable crontab for auto-restart/update
 * discord: Install a Discord Bot which will announce server status
 * raidhours: Allows to enable raids at certains hours. You need to configure the script and run "conan crontab"


# First step: Install the server, as root

Clone the repository containing the bash script and the python script. 

	git clone https://github.com/Slympp/ConanLinuxScript

Open a terminal as root terminal, and run the main script where you have cloned the repository

	./conan install

(Optional) Install the Discord bot. It will announce the shutdowns/updates/reboots

	./conan discord


Move both bash and python script in your /home/$user/

	cp conan discord_bot.py /home/steam/


Installation is almost finished, disconnect from you session


# Second step: Using the server, as $user

Login as $user and open a terminal


(Optional) Set up crontab

	./conan crontab


Start your server (not needed if you've set up a crontab for auto-restarter)

	./conan start


Check that your server is running.

	./conan show


Look at the logs by attaching the screen. Detach with Ctrl + A + D

	./conan screen



# Known issues

conan screen error : "Cannot open your terminal '/dev/pts/x' - please check."
* make sure you are REALLY logged as $user.
* If it don't works, try "script /dev/null"

# Changelog

Version 8
 * many fixs
 * stop: now wait that the PID is really killed before closing 
 * [NEW] "wait" parameter for start: Loop for 10mn trying to run a server if there's one currently running 
 * [NEW] raidhours: you need to configure a RaidHoursStart and RaidHoursDuration at the top of the script. It will reboot server and send a Discord message when needed

Version 7
 * User guide added
 * Server password handling removed (need to check this later)
 * Reboot command added

Version 6
 * Discord Bot announcer added
 * Fixed some prompts
