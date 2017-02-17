# Conan Linux Script

Made by Slymp, with and for the Conan Exiles community

 * (WIP) install   : Installs the whole stuff
     * creates specific user
     * set up basic iptables
     * install screen, wine 2.0, steamCmd 
     * download server files
     * configure crontab for auto-restart/update

 * start           : Starts server. Checks for servers already running
 * stop            : Stops safely servers by sending a SIGINT
 * update          : Apply a pending update. Closes and restarts the servers properly
 * (WIP) valide    : Checks Conan Exiles server files.
 * show            : Display running servers and their id
 * screen [id]     : Display console. Use "Ctrl + A D" to quit the screen without stopping the server
