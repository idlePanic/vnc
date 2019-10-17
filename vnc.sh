#!/bin/bash


# check if vnc not installed install vnc 
vnc_not_installed=$(dpkg -s tigervnc 2>&1 | grep "not installed")

if [ -n "$vnc_not_installed" ];then
  echo "Installing vnc"
  sudo apt-get install tigervnc* 
fi


# config vnc 
mkdir -p ~/.vnc
echo -en "\n\n"
sudo vncpasswd < password.config
echo -en "\n\n"


# make script for running vnc as service
##### !!! if you want uncomment vnc manual please comment this code

sudo echo "#!/bin/bash
sudo  x0vncserver -passwordfile ~/.vnc/passwd -display :0
#sudo x0vncserver -passwordfile ~/.vnc/passwd -display :0 >/dev/null 2>&1 &">>/usr/bin/vnc.sh

sudo chmod 744 /usr/bin/vnc.sh

# make vnc service

sudo touch /etc/systemd/system/vnc.service

#config vnc service

sudo echo "[Unit]
After=network.target

[Service]
ExecStart=/usr/bin/vnc.sh

[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/vnc.service


sudo chmod 664 /etc/systemd/system/vnc.service


# create rhis timer service for start vnc after desktop is loading
#this timer service automatically run afte 2 minutes and activate vnc

sudo touch /etc/systemd/system/startvnc.timer

sudo echo "[Unit]
Description=vnc timer

[Timer]
OnBootSec=2m
Unit=vnc.service

[Install]
WantedBy=default.target" >> /etc/systemd/system/startvnc.timer

sudo chmod 664 /etc/systemd/system/startvnc.timer

# reload service content
sudo systemctl daemon-reload

# auto start vnc service
sudo systemctl enable startvnc.timer

# start vnc service
sudo systemctl start vnc.service

####!!! end of servicing vnc  IF YOU WANT RUN VNC MANUALLY PLEASE COMMENT ABOVE CODE




#####  START of MANUAL VNC
#####  IF YOU WANT START VNC MANUALLY,   UNCOMMENT BELOW CODE
#####  

#sudo echo "alias vncstart='x0vncserver -passwordfile ~/.vnc/passwd -display :0 >/dev/null 2>&1 &';" >>  ~/.bashrc

#source ~/.bashrc

#####  END of MANUAL VNC

