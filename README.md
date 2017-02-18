# Conan Linux Script

Made by Slymp, with and for the Conan Exiles community

 * start: Starts server. Checks for servers already running
 * stop: Stops safely servers by sending a SIGINT
 * update\t\t: Apply a pending update. Closes and restarts the servers properly
 * show: Display running servers and their id
 * screen [id]: Display console. Use "Ctrl + A D" to quit the screen without stopping the server

 * (WIP) install: Installs the whole stuff
     * creates specific user
     * (TODO) set up basic iptables
     * install screen, wine 2.0, steamCmd
     * download server files
	
 * (WIP) validate: Checks Conan Exiles server files.
* crontab: Allows to enable crontab for auto-restart/update
