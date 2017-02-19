# Conan Linux Script

Made by Slymp, with and for the Conan Exiles community

 * start: Starts server. Checks for servers already running
 * stop: Stops safely servers by sending a SIGINT
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

# Installation

git clone
conan install
cp conan & script python dans /home/$user
su steam
conan start

# Known issues

Cannot open your terminal '/dev/pts/7' - please check.
=> script /dev/null

# Changelog

Version 6
 * Add a Discord Bot announcer
 * Fix some prompts
