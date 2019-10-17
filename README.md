# vnc
this script will install and config vnc for debian platform
1) if vnc not installed on your machine script install tigervnc
2) make vnc directory and set password (you can set password by editing password.config)
3) make vnc.sh file in /usr/bin for running vnc as service
4) make vnc.service file in /etc/systemd/system that run vnc.sh
5) make startvnc.timer for running vnc.service after 2 minutes that desktop is loading  (if we enable vnc.service we have problem because vnc.service run after system is turn on but desktop not running so vnc can't find display:0)
6) enable startvnc.timer

also if you want running vnc manually you must comment line 23 to 72 and uncomment line 83, 84 , 85

#manually start vnc
1) make vncstart alias in bashrc 
2) reload bashrc file


----------------------enjoy-------------------------------
