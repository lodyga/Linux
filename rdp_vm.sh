$ ssh ubuntu@158.101.162.117
$ ssh ubuntu@138.3.245.206
$ ssh ubuntu@130.61.85.9
$ ssh ubuntu@158.180.37.171

sudo apt update
sudo apt install ubuntu-desktop-minimal -y  # GNOME-based desktop

sudo apt install xrdp -y  # remote server graphical desktop
sudo systemctl enable --now xrdp
sudo systemctl status xrdp

sudo adduser rdpuser

ssh -L 3389:localhost:3389 ubuntu@138.3.245.206  # create SSH tunnel for Remmina
ssh -L 3389:localhost:3389 ubuntu@158.180.37.171

# install light desktop
sudo apt install xfce4 xfce4-goodies -y
# Then configure rdpuser to use XFCE:
sudo -iu rdpuser
echo "startxfce4" > ~/.xsession  # echo "gnome-session" > ~/.xsession
chmod +x ~/.xsession
exit
sudo systemctl restart xrdp
# systemctl daemon-reload

setxkbmap -layout pl -variant studio
xfce4-keyboard-settingse


# polish language
sudo apt install language-pack-gnome-pl language-pack-gnome-pl-base
sudo update-locale LANG=pl_PL.UTF-8
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8


