#!/bin/bash

# Linux post install setup file
# Created by Mihai Luca <mihailuca406@gmail.com>
# Distribution currently used: feren OS based on Mint


# VARIABLES

# SMTP Server variable is configured in the SETTINGS/Email section
MAIN_EMAIL=mihailuca406@gmail.com
GIT_EMAIL=$MAIN_EMAIL
FIRSTNAME=Mihai
LASTNAME=Luca
RUN_FOLDER=~/Desktop/
SCRIPTS_FOLDER=~/Dropbox/Bash-Scripts/
BINARIES_FOLDER=~/Dropbox/bin/
CODE_FOLDER=~/Dropbox/Code/
RAMDISK_MOUNT_POINT=/mnt/ramdisk/
UBUNTU_CODENAME="$(lsb_release -a 2> /dev/null | grep Codename | tr -d [:space:] | cut -d: -f2)"
DEFAULT_TERMINAL_EMULATOR=/usr/bin/terminology
export CURRENT_USER=$USER

# PRELIMINARY SETTINGS & CHECKS

if [ ! -d "$RUN_FOLDER" ]; then
    mkdir -p "$RUN_FOLDER"
fi
cd "$RUN_FOLDER" # additional files will be created in this folder
exec 2> install-log.txt # send error stream to log file

# ONLINE SOURCES

ZSH_SETUP=https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
VIRTUALBOX=https://download.virtualbox.org/virtualbox/5.2.18/virtualbox-5.2_5.2.18-124319~Ubuntu~bionic_amd64.deb
VBOX_EXTENSION_PACK=https://download.virtualbox.org/virtualbox/6.2.18/Oracle_VM_VirtualBox_Extension_Pack-5.2.18.vbox-extpack
TEAMSPEAK=http://dl.4players.de/ts/releases/3.2.2/TeamSpeak3-Client-linux_amd64-3.2.2.run
DISCORD=https://discordapp.com/api/download?platform=linux&format=deb
TEAMVIEWER=https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
ATOM=https://atom.io/download/deb
DMD=http://downloads.dlang.org/releases/2.x/2.085.0/dmd_2.085.0-0_amd64.deb
TOR_BROWSER=https://www.torproject.org/dist/torbrowser/8.0.8/tor-browser-linux64-8.0.8_en-US.tar.xz

# REPOSITORIES

# REPOSITORIES/Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo bash -c 'echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublime-text.list'

# REPOSITORIES/Wine
wget -nc https://dl.winehq.org/wine-builds/Release.key -O- | sudo apt-key add -
sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ $UBUNTU_CODENAME main"

# REPOSITORIES/Lutris
sudo add-apt-repository ppa:lutris-team/lutris

# REPOSITORIES/webupd8
sudo add-apt-repository -y ppa:nilarimogard/webupd8


# INSTALL

# INSTALL/apt

sudo apt update -y
sudo apt install -y vim
sudo apt install -y zsh
sudo apt install -y tmux
sudo apt install -y terminology
sudo apt install -y mc
sudo apt install -y top
sudo apt install -y htop
sudo apt install -y pstree
sudo apt install -y finger
sudo apt install -y xclip
sudo apt install -y nnn
sudo apt install -y w3m
sudo apt install -y postfix
sudo apt install -y mailutils
sudo apt install -y clamav
sudo apt install -y gparted
sudo apt install -y woeusb
sudo apt install -y gkrellm
sudo apt install -y g++
sudo apt install -y ldc
sudo apt install -y git
sudo apt install -y sublime-text
sudo apt install -y sublime-merge
sudo apt install -y splint
sudo apt install -y splint-doc-html
sudo apt install -y ddd
sudo apt install -y ddd-doc
sudo apt install -y valgrind
sudo apt install -y valgrind-dbg
sudo apt install -y dia
sudo apt install -y ttf-mscorefonts-installer
sudo apt install -y fonts-inconstolata
sudo apt install -y pandoc
sudo apt install -y img2pdf
sudo apt install -y fbreader
sudo apt install -y cmus
sudo apt install -y audacious
sudo apt install -y audacious-plugins
sudo apt install -y finch
sudo apt install -y dropbox
sudo apt install -y skypeforlinux
sudo apt install -y qbittorrent
sudo apt install -y dict
sudo apt install -y dictd
sudo apt install -y dict-gcide
sudo apt install -y dict-moby-thesaurus
sudo apt install -y dict-freedict-eng-deu
sudo apt install -y dict-freedict-deu-eng
sudo apt install -y dict-freedict-eng-fra
sudo apt install -y dict-freedict-fra-eng
sudo apt install -y dict-freedict-eng-rom
sudo apt install -y gimp
sudo apt install -y gimp-plugin-registry 
sudo apt install -y winehq-staging
sudo apt install -y playonlinux
sudo apt install -y lutris
sudo apt install -y steam
sudo apt install -y flatpak
sudo apt install -y gnome-software-plugin-flatpak

# INSTALL/flatpak

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# UberWriter
echo '#!/bin/bash' > install-uberwriter.sh
echo 'flatpak install flathub de.wolfvollprecht.UberWriter' >> install-uberwriter.sh
chmod +x install-uberwriter.sh
echo "Run install-uberwriter.sh after reboot." 1>&2

# INSTALL/Download

# INSTALL/Download/VirtualBox
wget -O virtualbox.deb $VIRTUALBOX
sudo dpkg -i virtualbox.deb
rm -f virtualbox.deb
wget $VBOX_EXTENSION_PACK
echo "Virtualbox Extension Pack downloaded, install manually." 1>&2

# INSTALL/Download/TeamSpeak
wget -O teamspeak.run $TEAMSPEAK
chmod +x teamspeak.run
./teamspeak.run
rm -f teamspeak.run
sudo mv TeamSpeak* /opt/
sudo chown -R $USER:$USER /opt/TeamSpeak*
echo "TeamSpeak: create a lanucher pointing to /opt/TeamSpeak3-Client-linux_amd64/ts3client_runscript.sh" 1>&2

# INSTALL/Download/Discord
wget -O discord.deb $DISCORD
sudo dpkg -i discord.deb
rm -f discord.deb
sudo apt install -f -y

# INSTALL/TeamViewer
wget -O teamviewer.deb $TEAMVIEWER
sudo dpkg -i teamviewer.deb
rm -f teamviewer.deb
sudo apt install -f -y

# INSTALL/Download/Atom
wget -O atom.deb $ATOM
sudo dpkg -i atom.deb
rm -f atom.deb

# INSTALL/Download/DMD
wet -O dmd.deb $DMD
sudo dpkg -i dmd.deb
rm -f dmd.deb

# INSTALL/Download/Tor Browser
wget -O tor-browser.tar.xz $TOR_BROWSER
tar -xvf tor-browser.tar.xz
sudo mv tor-browser_en-US /opt/
sudo chown $USER:$USER /opt/tor-browser_en-US
echo "Tor Browser installed in /opt. Create menu launcher manually." 1>&2
rm -f tor-browser.tar.sz


# SETTINGS

# SETTINGS/Git
git config --global user.name "$FIRSTNAME $LASTNAME"
git config --global user.email "$GIT_EMAIL"

# SETTINGS/Reduce swap tendency
sudo -E bash -c 'echo "# $CURRENT_USER" >> /etc/sysctl.conf'
sudo bash -c 'echo "# Reduce swap tendency" >> /etc/sysctl.conf'
sudo bash -c 'echo "vm.swappiness = 10" >> /etc/sysctl.conf'

# SETTINGS/Email
# Required software already installed in the INSTALL/apt section
# Configure Authetication
export SMTP_SERVER='[smtp.gmail.com]:587'
echo "Enter the Email address for your account: "
read EMAIL
echo "Enter your password: "
read -s PASSWORD
echo "Confirm your password: "
read -s PASSWORD2
while [ "$PASSWORD" != "$PASSWORD2" ]; do
    echo "The passwords did not match. Try again."
    echo "Enter your password: "
    read -s PASSWORD
    echo "Confirm your password: "
    read -s PASSWORD2
done
unset PASSWORD2
echo "$SMTP_SERVER    $EMAIL:$PASSWORD" > sasl_passwd
unset PASSWORD
sudo chown root:root sasl_passwd
sudo chmod 600 sasl_passwd
sudo mv sasl_passwd /etc/postfix/
# Configure Postfix
sudo bash -c 'echo "" >> /etc/postfix/main.cf'
sudo -E bash -c 'echo "# $CURRENT_USER" >> /etc/postfix/main.cf'
sudo vim /etc/postfix/main.cf -c 'g/^relayhost\ =\ *$/d' -c wq
sudo -E bash -c 'echo "relayhost = $SMTP_SERVER" >> /etc/postfix/main.cf'
sudo bash -c 'echo "smtp_use_tls = yes" >> /etc/postfix/main.cf'
sudo bash -c 'echo "smtp_sasl_auth_enable = yes" >> /etc/postfix/main.cf'
sudo bash -c 'echo "smtp_sasl_security_options = noanonymous" >> /etc/postfix/main.cf'
sudo bash -c 'echo "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd" >> /etc/postfix/main.cf'
sudo bash -c 'echo "smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt" >> /etc/postfix/main.cf'
# Process Password File
sudo postmap /etc/postfix/sasl_passwd 
# Enable large messages
sudo postconf -e mailbox_size_limit=0
sudo postconf -e message_size_limit=0
# Restart Postfix
sudo systemctl restart postfix.service
# Enable Postfix on boot (might not be needed)
sudo systemctl enable postfix.service
# Less secure apps have to be enabled in Gmail
echo "Less secure apps have to be enabled in Gmail: https://myaccount.google.com/lesssecureapps" 1>&2
# Test Email
echo "Linux Email configuration completed." | mail -s "Linux Email" "$EMAIL"
unset EMAIL

# SETTINGS/Set hardware clock to local time (if you are using dual-boot with Windows)
timedatectl set-local-rtc 1 --adjust-system-clock

# SETTINGS/Default Editor
sudo update-alternatives --set editor /usr/bin/vim.basic

# SETTINGS/zsh
bash -c "$(curl -fsSL $ZSH_SETUP)"
sed -i 's/ZSH_THEME="robbyrussell"/# ZSH_THEME="robbyrussell"\nZSH_THEME="lukerandall"/' ~/.zshrc
echo 'source $HOME/.bash_aliases' >> ~/.zshrc

# SETTINGS/Default Terminal Emulator
sudo update-alternatives --set x-terminal-emulator $DEFAULT_TERMINAL_EMULATOR

# SETTINGS/grub
sudo vim /etc/default/grub -c '%s/GRUB_TIMEOUT=10/GRUB_TIMEOUT=3/' -c wq
sudo update-grub
# Grub btrfs bug workaround
sudo grub-editenv create

# SETTINGS/vimrc
sudo -E bash -c 'echo "\" $CURRENT_USER" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set number" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set is" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set cindent" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set expandtab" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set tabstop=4" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set shiftwidth=4" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set mouse=a" >> /etc/vim/vimrc.local'

# SETTINGS/tmux
echo 'set -g default-terminal "screen-256color"' > ~/.tmux.conf.bak
sudo bash -c 'echo -e "\" set background=dark" >> /etc/vim/vimrc.local'

# SETTINGS/Aliases
if [ -f ~/.bash_aliases ]; then
    cp ~/.bash_aliases ~/.bash_aliases.bak
    > ~/.bash_aliases
fi

echo "alias xclip='xclip -selection c'" >> ~/.bash_aliases

# SETTINGS/Ramdisk
sudo mkdir $RAMDISK_MOUNT_POINT

# SETTINGS/Folders and Links

# ~/bin/
mkdir ~/bin/
# Scripts
ln -s "$SCRIPTS_FOLDER/currency-converter/eur.sh" ~/bin/eur
ln -s "$SCRIPTS_FOLDER/currency-converter/usd.sh" ~/bin/usd
ln -s "$SCRIPTS_FOLDER/currency-converter/ron.sh" ~/bin/ron
ln -s "$SCRIPTS_FOLDER/rickrollrc-master/roll.sh" ~/bin/roll
ln -s "$SCRIPTS_FOLDER/weather.sh" ~/bin/weather
ln -s "$SCRIPTS_FOLDER/to.sh" ~/bin/to
ln -s "$SCRIPTS_FOLDER/empty-trash.sh" ~/bin/empty-trash
ln -s "$SCRIPTS_FOLDER/dark.sh" ~/bin/dark
ln -s "$SCRIPTS_FOLDER/compile.sh" ~/bin/compile
ln -s "$SCRIPTS_FOLDER/clean-usb.sh" ~/bin/clean-usb
ln -s "$SCRIPTS_FOLDER/lookup.sh" ~/bin/lookup
ln -s "$SCRIPTS_FOLDER/lookup.sh" ~/bin/lk
ln -s "$SCRIPTS_FOLDER/bookmark.sh" ~/bin/bookmark
ln -s "$SCRIPTS_FOLDER/bookmark.sh" ~/bin/bk
ln -s "$SCRIPTS_FOLDER/end-session.sh" ~/bin/end-session
ln -s "$SCRIPTS_FOLDER/safe-reboot.sh" ~/bin/safe-reboot
ln -s "$SCRIPTS_FOLDER/timer.sh" ~/bin/timer
ln -s "$SCRIPTS_FOLDER/xopen.sh" ~/bin/xopen
ln -s "$SCRIPTS_FOLDER/xrun.sh" ~/bin/xrun
ln -s "$SCRIPTS_FOLDER/wordwrap-paste.sh" ~/bin/wp
ln -s "$SCRIPTS_FOLDER/sound.sh" ~/bin/sound
ln -s "$SCRIPTS_FOLDER/streams/wallstream.sh" ~/bin/wallstream
ln -s "$SCRIPTS_FOLDER/streams/playstream.sh" ~/bin/playstream
ln -s "$SCRIPTS_FOLDER/streams/twitch.sh" ~/bin/twitch
ln -s "$SCRIPTS_FOLDER/streams/wtwitch.sh" ~/bin/wtwitch
ln -s "$SCRIPTS_FOLDER/streams/sc2-streams.sh" ~/bin/sc2-streams
ln -s "$SCRIPTS_FOLDER/search-replace.sh" ~/bin/search-replace
ln -s "$SCRIPTS_FOLDER/goto.sh" ~/bin/goto
ln -s "$SCRIPTS_FOLDER/work-done.sh" ~/bin/work-done
ln -s "$SCRIPTS_FOLDER/ramdisk.sh" ~/bin/ramdisk
# Cmus
ln -s "$SCRIPTS_FOLDER/cmus-lyrics-master/cmus-lyrics" ~/bin/cmus-lyrics
ln -s "$SCRIPTS_FOLDER/cmus-local/cmus-save.sh" ~/bin/cmus-save     
ln -s "$SCRIPTS_FOLDER/cmus-local/cmus-load.sh" ~/bin/cmus-load    
ln -s "$SCRIPTS_FOLDER/cmus-local/playlist.sh" ~/bin/playlist     
ln -s "$SCRIPTS_FOLDER/cmus-local/playlists.sh" ~/bin/playlists     
ln -s "$SCRIPTS_FOLDER/cmus-local/song.sh" ~/bin/song            

# Binaries
ln -s "$BINARIES_FOLDER/milestokm" ~/bin/milestokm
ln -s "$BINARIES_FOLDER/kmtomiles" ~/bin/kmtomiles
ln -s "$BINARIES_FOLDER/height" ~/bin/height
ln -s "$BINARIES_FOLDER/cm" ~/bin/cm
ln -s "$BINARIES_FOLDER/word-frequency" ~/bin/word-frequency
ln -s "$BINARIES_FOLDER/aec" ~/bin/aec

# ~/Desktop/
ln -s ~/Dropbox/Documents/Carti/ ~/Desktop/Carti
ln -s ~/Music/  ~/Desktop/Music
ln -s ~/Downloads/  ~/Desktop/Downloads
ln -s "$CODE_FOLDER" ~/Desktop/Code
ln -s "$SCRIPTS_FOLDER" ~/Desktop/Bash-Scripts

# SETTINGS/Autostart

# Terminal
which $DEFAULT_TERMINAL_EMULATOR > /dev/null || DEFAULT_TERMINAL_EMULATOR=gnome-terminal
> /home/$USER/.config/autostart/Terminal.desktop
bash -c 'echo "[Desktop Entry]" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "Type=Application" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "Exec=$DEFAULT_TERMINAL_EMULATOR -e tmux" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "X-GNOME-Autostart-enabled=true" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "NoDisplay=false" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "Hidden=false" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "Name[en_US]=Terminal" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "Comment[en_US]=No description" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "X-GNOME-Autostart-Delay=0" >> /home/$USER/.config/autostart/Terminal.desktop'

# SETTINGS/Cosmetics

# Audacious Winamp skin
sudo cp "$(find ~ -name *winamp_classic.wsz 2> /dev/null | head -1)" /usr/share/audacious/Skins/

# mc skin
mkdir -p ~/.local/share/mc/skins/
cp "$(find ~ -name darkcourses_green.ini 2> /dev/null | head -1)" ~/.local/share/mc/skins/
gnome-terminal -e mc
echo "Please exit the mc instance that opened, using File->Exit."
echo "Press ENTER to confirm."
read CONFIRMATION
vim ~/.config/mc/ini -c "%s/skin=default/skin=darkcourses_green.ini" -c wq

# Cmus Taskbar Controls
unzip "$(find ~ -name cmus-taskbar-controls.zip 2> /dev/null | head -1)" -d ~/.cinnamon/configs/

# SETTINGS/Wine Tweaks
sudo vim /etc/systemd/system.conf -c '%s/#DefaultLimitNOFILE=/DefaultLimitNOFILE=1048576/' -c wq
sudo vim /etc/systemd/user.conf -c '%s/#DefaultLimitNOFILE=/DefaultLimitNOFILE=1048576/' -c wq

# DONE
echo -e "\nDone!"
echo -n "Restart your system now? (Y/n): "
read INPUT
if [ "$INPUT" == "n" ] || [ "$INPUT" == "N" ]; then
    exit 0
else
    sudo reboot
fi

