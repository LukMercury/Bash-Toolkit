#!/bin/bash

# Linux post install setup file
# Created by Mihai Luca <mihailuca406@gmail.com>
# Distribution currently used: Pop!_OS based on Ubuntu

# ------------------------------------------------------------------------------------------------------------------------------

# VARIABLES

# SMTP Server variable is configured in the SETTINGS/Email section
export MAIN_EMAIL=mihailuca406@gmail.com
export GIT_EMAIL=$MAIN_EMAIL
export FIRSTNAME=Mihai
export LASTNAME=Luca
export RUN_FOLDER=$HOME/Desktop
export DOCUMENTS_FOLDER=/mnt/raid1/Documents
export MUSIC_FOLDER=/mnt/raid1/Music
export PICTURES_FOLDER=/mnt/raid1/Pictures
export VIDEOS_FOLDER=/mnt/raid1/Videos
export DOWNLOADS_FOLDER=/mnt/raid1/Downloads
export SCRIPTS_FOLDER=/mnt/raid1/Scripts
export BINARIES_FOLDER=/mnt/raid1/Binaries
export SOFTWARE_FOLDER=/mnt/raid1/Kituri
export CODE_FOLDER=/mnt/raid1/Code
export UBUNTU_CODENAME="$(lsb_release -a 2> /dev/null | grep Codename | tr -d [:space:] | cut -d: -f2)"
export DEFAULT_TERMINAL_EMULATOR=/usr/bin/terminology
export CURRENT_USER=$USER
export HOSTNAME=forge
export DEFAULT_PHONE_IP=192.168.0.102

# ONLINE SOURCES

ZSH_SETUP="https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
VIRTUALBOX="https://download.virtualbox.org/virtualbox/7.0.0/virtualbox-7.0_7.0.0-153978~Ubuntu~jammy_amd64.deb"
VBOX_EXTENSION_PACK="https://download.virtualbox.org/virtualbox/7.0.0/Oracle_VM_VirtualBox_Extension_Pack-7.0.0.vbox-extpack"
DISCORD="https://discordapp.com/api/download?platform=linux&format=deb"
TEAMVIEWER="https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"
VNCVIEWER="https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.21.920-Linux-x64.deb"
DMD="https://s3.us-west-2.amazonaws.com/downloads.dlang.org/releases/2021/dmd_2.098.0-0_amd64.deb"
SKYPE="https://go.skype.com/skypeforlinux-64.deb"
ZOOM="https://zoom.us/client/latest/zoom_amd64.deb"
TOR_BROWSER="https://dist.torproject.org/torbrowser/11.0.1/tor-browser-linux64-11.0.1_en-US.tar.xz"
VSCODE="https://az764295.vo.msecnd.net/stable/d045a5eda657f4d7b676dedbfa7aab8207f8a075/code_1.72.2-1665614327_amd64.deb"
GITKRAKEN="https://release.axocdn.com/linux/gitkraken-amd64.deb"

# ------------------------------------------------------------------------------------------------------------------------------

# First Upgrade System
if [ ! -f "upgraded" ]; then
    sudo apt clean -y
    sudo apt update -y
    sudo dpkg --configure -a
    sudo apt full-upgrade -y
    sudo apt autoremove --purge -y
    touch upgraded
    echo "Upgrade complete. Please restart your system."
    exit 0
fi

# PRELIMINARY SETTINGS & CHECKS

if [ ! -d "$RUN_FOLDER" ]; then
    mkdir -p "$RUN_FOLDER"
fi
cd "$RUN_FOLDER" # additional files will be created in this folder
exec 2> install-log.txt # send error stream to log file

# Desktop Environment - Gnome or KDE
read -N 1000000 -t 0.001 # Clear input
echo -n "Gnome or KDE? (g/k): " 
read X_VERSION
X_VERSION=$(echo $X_VERSION | tr '[:upper:]' '[:lower:]')
while [ "$X_VERSION" != "g" ] && [ "$X_VERSION" != "k" ]; do
    read -N 1000000 -t 0.001 # Clear input
    echo -n "Please enter 'g' or 'k': " 
    read X_VERSION
    X_VERSION=$(echo $X_VERSION | tr '[:upper:]' '[:lower:]')
done

# Links to custom binaries and scripts (~/bin)
read -N 1000000 -t 0.001 # Clear input
echo -n "Create links to custom binaries and scripts? (Y/n): "
read BINARY_LINKS
if [ "$BINARY_LINKS" == "y" ] || [ "$BINARY_LINKS" == "Y" ] || [ "$BINARY_LINKS" == "" ]; then
    BINARY_LINKS="y"
fi

# Links to folders
read -N 1000000 -t 0.001 # Clear input
echo -n "Create links to folders? (Y/n): "
read FOLDER_LINKS
if [ "$FOLDER_LINKS" == "y" ] || [ "$FOLDER_LINKS" == "Y" ] || [ "$FOLDER_LINKS" == "" ]; then
    FOLDER_LINKS="y"
fi

# ------------------------------------------------------------------------------------------------------------------------------


# REPOSITORIES

# REPOSITORIES/Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# REPOSITORIES/Wine
wget -nc https://dl.winehq.org/wine-builds/winehq.key -O- | sudo apt-key add -
sudo apt-add-repository -y "deb https://dl.winehq.org/wine-builds/ubuntu/ $UBUNTU_CODENAME main"

# REPOSITORIES/Lutris
sudo add-apt-repository -y ppa:lutris-team/lutris

# REPOSITORIES/Mesa
sudo add-apt-repository -y ppa:kisak/kisak-mesa

# REPOSITORIES/webupd8
sudo add-apt-repository -y ppa:nilarimogard/webupd8

# REPOSITORIES/bashtop
# sudo add-apt-repository ppa:bashtop-monitor/bashtop

# REPOSITORIES/Spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# INSTALL

# INSTALL/add architecture
sudo dpkg --add-architecture i386

# INSTALL/apt

# Cleanup
sudo apt purge -y apport
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt install -f -y
# Install
sudo apt install -y firefox
sudo apt install -y firefox-locale-en
sudo apt install -y vim
sudo apt install -y neovim
rm -f $HOME/.zshrc
sudo apt install -y zsh
sudo apt install -y tmux
sudo apt install -y terminology
sudo apt install -y mc
sudo apt install -y tree
sudo apt install -y top
sudo apt install -y htop
sudo apt install -y bashtop
sudo apt install -y btop
sudo apt install -y duf
sudo apt install -y anacron
sudo apt install -y errno
sudo apt install -y pstree
sudo apt install -y finger
sudo apt install -y dconf-editor
sudo apt install -y xclip
sudo apt install -y xdotool
sudo apt install -y taskwarrior
sudo apt install -y gpaste
sudo apt install -y gnome-shell-extensions-gpaste
sudo apt install -y caffeine
sudo apt install -y libnotify-bin
sudo apt install -y rwho
sudo apt install -y openssh-server
sudo apt install -y sshfs
sudo apt install -y traceroute
sudo apt install -y bridge-utils
sudo apt install -y nmap
sudo apt install -y tcpdump
sudo apt install -y whois
sudo apt install -y remmina
sudo apt install -y kazam
sudo apt install -y nnn
sudo apt install -y w3m
sudo apt install -y postfix
sudo apt install -y ethtool
sudo apt install -y mailutils
sudo apt install -y gparted
sudo apt install -y psensor
sudo apt install -y g++
sudo apt install -y global
sudo apt install -y ldc
sudo apt install -y openjdk-14-jdk
sudo apt install -y php
sudo apt install -y sqlite3
sudo apt install -y python3-pip
sudo apt install -y python3-setuptools
sudo apt install -y python3-libs
sudo apt install -y pipx
sudo apt install -y python3-lxml
sudo apt install -y git
sudo apt install -y cmake
sudo apt install -y cmake-gui
sudo apt install -y sublime-text
sudo apt install -y sublime-merge
sudo apt install -y notepadqq
sudo apt install -y cpputest
sudo apt install -y recoll
sudo apt install -y antiword
sudo apt install -y djvulibre-bin
sudo apt install -y python3-mutagen
sudo apt install -y unrtf
sudo apt install -y splint
sudo apt install -y splint-doc-html
sudo apt install -y liboctave-dev
sudo apt install -y ddd
sudo apt install -y ddd-doc
sudo apt install -y valgrind
sudo apt install -y valgrind-dbg
sudo apt install -y wireshark
sudo apt install -y dia
sudo apt install -y ttf-mscorefonts-installer
sudo apt install -y fonts-inconsolata
sudo apt install -y pandoc
sudo apt install -y texlive
sudo apt install -y img2pdf
sudo apt install -y calibre
sudo apt install -y fbreader
sudo apt install -y cmus
sudo apt install -y kodi
sudo apt install -y cava
sudo apt install -y audacious
sudo apt install -y audacious-plugins
sudo apt install -y spotify-client
sudo apt install -y vlc
sudo apt install -y finch
sudo apt install -y alacarte
sudo apt install -y qbittorrent
sudo apt install -y transmission-cli
sudo apt install -y youtube-dl
sudo apt install -y krita
sudo apt install -y gimp
# Wine dependencies
sudo apt install -y libgnutls30:i386 
sudo apt install -y libldap-2.4-2:i386 
sudo apt install -y libgpg-error0:i386 
sudo apt install -y libsqlite3-0:i386
# Lutris Drivers Nvidia
# Support for Vulkan API
# sudo apt install -y libvulkan1
# sudo apt install -y libvulkan1:i386
# Lutris Drivers AMD
# Support for 32bit games
sudo apt install -y libgl1-mesa-dri:i386
# Support for Vulkan API
sudo apt install -y mesa-vulkan-drivers 
sudo apt install -y mesa-vulkan-drivers:i386
# Wine
sudo apt install -y --install-recommends winehq-stable
sudo apt install -y playonlinux
sudo apt install -y lutris
sudo apt install -y steam
sudo apt install -y mangohud

# Protontricks
bash -c 'python3 -m pip install protontricks'

# Streamdeck UI
# python3-pip installed above
sudo apt install -y libhidapi-libusb0
sudo apt install -y libxcb-xinerama0
sudo bash -c 'echo "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"0fd9\", TAG+=\"uaccess\"" > /etc/udev/rules.d/70-streamdeck.rules'
pip3 install streamdeck-ui --user

# INSTALL/apt/gnome or kde
if [ "$X_VERSION" == "g" ]; then
    sudo apt install -y doublecmd-gtk
    sudo apt install -y gnome-tweaks
    sudo apt install -y pavucontrol
else 
    sudo apt install -y doublecmd-qt
    sudo apt install -y pavucontrol-qt
fi

# INSTALL/pip3
pip3 install requests
pip3 install lxml
pip3 install wget

# INSTALL/npm
sudo apt install -y npm
sudo npm i console-stopwatch --global
sudo npm install jsonlint -g

# INSTALL/nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

# INSTALL/flatpak
sudo apt install --user -y flatpak
sudo apt install --user -y gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user -y flathub com.leinardi.gkraken
flatpak run com.leinardi.gkraken --add-udev-rule
flatpak install --user -y teamspeak
flatpak install --user -y flathub org.gnome.gitlab.somas.Apostrophe
flatpak install --user -y planner
flatpak install --user -y flathub com.axosoft.GitKraken
flatpak install --user -y com.github.IsmaelMartinez.teams_for_linux

# INSTALL/Download

# INSTALL/Download/VirtualBox
wget -O virtualbox.deb "$VIRTUALBOX" 2> /dev/null # get rid of excessive output
sudo dpkg -i virtualbox.deb || sudo apt install -f -y
rm -f virtualbox.deb
wget $VBOX_EXTENSION_PACK 2> /dev/null  # get rid of excessive output
echo "Virtualbox Extension Pack downloaded, install manually." 1>&2

# INSTALL/Download/Discord
wget -O discord.deb "$DISCORD" 2> /dev/null   
sudo dpkg -i discord.deb || sudo apt install -f -y
rm -f discord.deb

# INSTALL/Download/TeamViewer
wget -O teamviewer.deb "$TEAMVIEWER" 2> /dev/null   
sudo dpkg -i teamviewer.deb || sudo apt install -f -y
rm -f teamviewer.deb

# INSTALL/Download/VNC Viewer
wget -O vncviewer.deb "$VNCVIEWER" 2> /dev/null   
sudo dpkg -i vncviewer.deb || sudo apt install -f -y
rm -f vncviewer.deb

# INSTALL/Download/DMD
wget -O dmd.deb "$DMD" 2> /dev/null    
sudo dpkg -i dmd.deb || sudo apt install -f -y
rm -f dmd.deb

# INSTALL/Download/Visual Studio Code
wget -O vscode.deb "$VSCODE" 2> /dev/null 
sudo dpkg -i vscode.deb || sudo apt install -f -y
rm -f vscode.deb

# INSTALL/Download/Skype
wget -O skype.deb "$SKYPE" 2> /dev/null    
sudo dpkg -i skype.deb || sudo apt install -f -y
rm -f skype.deb

# INSTALL/Download/Zoom
wget -O zoom.deb "$ZOOM" 2> /dev/null    
sudo dpkg -i zoom.deb || sudo apt install -f -y
rm -f zoom.deb

# INSTALL/Download/Tor Browser
wget -O tor-browser.tar.xz "$TOR_BROWSER" 2> /dev/null    
tar -xvf tor-browser.tar.xz
sudo mv tor-browser_en-US /opt/
echo "Tor Browser installed in /opt. Create menu launcher manually." 1>&2
rm -f tor-browser.tar.xz

# INSTALL/Cleanup
sudo apt autoremove -y

# ------------------------------------------------------------------------------------------------------------------------------


# SETTINGS

# SETTINGS/Git
git config --global user.name "$FIRSTNAME $LASTNAME"
git config --global user.email "$GIT_EMAIL"

# SETTINGS/Reduce swap tendency
sudo bash -c 'echo "vm.swappiness = 10" >> /etc/sysctl.conf'

# SETTINGS/Max user watches
sudo bash -c 'echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf'

# SETTINGS/pulseaudio
# sed -i 's/; avoid-resampling/avoid-resampling/' /etc/pulse/daemon.conf
# sed -i 's/avoid-resampling = false/avoid-resampling = true/' /etc/pulse/daemon.conf
# sed -i '54 resample-method = src-sinc-best-quality'
# sed -i '81 i default-sample-format = s32le/' /etc/pulse/daemon.conf
# sed -i '83 i default-sample-rate = 192000/' /etc/pulse/daemon.conf
# pulseaudio -k
# pactl list short sinks >> install-log.txt 

# SETTINGS/Email
# Required software already installed in the INSTALL/apt section
# Configure Authetication
# export SMTP_SERVER='[smtp.gmail.com]:587'
# read -N 1000000 -t 0.001 # Clear input
# echo "Enter the Email address for your account: "
# read EMAIL
# echo "Enter your password: "
# read -s PASSWORD
# echo "Confirm your password: "
# read -s PASSWORD2
# while [ "$PASSWORD" != "$PASSWORD2" ]; do
#     read -N 1000000 -t 0.001 # Clear input
#     echo "The passwords did not match. Try again."
#     echo "Enter your password: "
#     read -s PASSWORD
#     echo "Confirm your password: "
#     read -s PASSWORD2
# done
# unset PASSWORD2
# echo "$SMTP_SERVER    $EMAIL:$PASSWORD" > sasl_passwd
# unset PASSWORD
# sudo chown root:root sasl_passwd
# sudo chmod 600 sasl_passwd
# sudo mv sasl_passwd /etc/postfix/
# # Configure Postfix
# sudo bash -c 'echo "" >> /etc/postfix/main.cf'
# sudo -E bash -c 'echo "# $CURRENT_USER" >> /etc/postfix/main.cf'
# sudo vim /etc/postfix/main.cf -c 'g/^relayhost\ =\ *$/d' -c wq
# sudo -E bash -c 'echo "relayhost = $SMTP_SERVER" >> /etc/postfix/main.cf'
# sudo bash -c 'echo "smtp_use_tls = yes" >> /etc/postfix/main.cf'
# sudo bash -c 'echo "smtp_sasl_auth_enable = yes" >> /etc/postfix/main.cf'
# sudo bash -c 'echo "smtp_sasl_security_options = noanonymous" >> /etc/postfix/main.cf'
# sudo bash -c 'echo "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd" >> /etc/postfix/main.cf'
# sudo bash -c 'echo "smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt" >> /etc/postfix/main.cf'
# # Process Password File
# sudo postmap /etc/postfix/sasl_passwd 
# # Enable large messages
# sudo postconf -e mailbox_size_limit=0
# sudo postconf -e message_size_limit=0
# # Restart Postfix
# sudo systemctl restart postfix.service
# # Enable Postfix on boot (may not be needed)
# sudo systemctl enable postfix.service
# # Less secure apps have to be enabled in Gmail
# echo "Less secure apps have to be enabled in Gmail: https://myaccount.google.com/lesssecureapps" 1>&2
# # Test Email
# echo "Linux Email configuration completed." | mail -s "Linux Email" "$EMAIL"
# unset EMAIL

# SETTINGS/Set hardware clock to local time (if you are using dual-boot with Windows)
# timedatectl set-local-rtc 1 --adjust-system-clock

# SETTINGS/Default Editor
sudo update-alternatives --set editor /usr/bin/vim.basic

# SETTINGS/zsh
rm -rf $HOME/.oh-my-zsh/
bash -c "$(curl -fsSL $ZSH_SETUP)"
sed -i 's/ZSH_THEME="robbyrussell"/# ZSH_THEME="robbyrussell"\nZSH_THEME="lukerandall"/' $HOME/.zshrc
# Make zsh your default shell (in case Oh-My-Zsh doesn't do it)
read -N 1000000 -t 0.001 # Clear input
echo "Changing default shell to zsh."
echo "Please enter your sudo password: "
read -s PASSWORD
echo $PASSWORD | chsh -s $(which zsh) $CURRENT_USER
unset PASSWORD
echo -e 'source $HOME/.bash_aliases\n' >> $HOME/.zshrc
echo -e 'if [ -n "$SSH_CONNECTION" ]; then\n' >> $HOME/.zshrc
echo -e '    . $HOME/.profile\n' >> $HOME/.zshrc
echo 'fi' >> $HOME/.zshrc

# SETTINGS/Default Terminal Emulator
which $DEFAULT_TERMINAL_EMULATOR > /dev/null || export DEFAULT_TERMINAL_EMULATOR=gnome-terminal
sudo update-alternatives --set x-terminal-emulator $DEFAULT_TERMINAL_EMULATOR
gsettings set org.gnome.desktop.default-applications.terminal exec $DEFAULT_TERMINAL_EMULATOR

# SETTINGS/tmux
mkdir -p $HOME/.config/tmux
echo 'set -g default-terminal "screen-256color"' > .config/tmux/tmux.conf
echo 'set -g history-limit 10000' > .config/tmux/tmux.conf

# SETTINGS/vim-plug/vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# SETTINGS/vim-plug/nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# SETTINGS/vimrc 1 (same as nvim/init.vim)
echo "\" $USER" >> $HOME/.vimrc
echo >> $HOME/.vimrc
echo "\" set background=dark" >> $HOME/.vimrc
echo "set number" >> $HOME/.vimrc
echo "set is" >> $HOME/.vimrc
echo "set cindent" >> $HOME/.vimrc
echo "set expandtab" >> $HOME/.vimrc
echo "set tabstop=4" >> $HOME/.vimrc
echo "set shiftwidth=4" >> $HOME/.vimrc
echo "set mouse=a" >> $HOME/.vimrc
echo "set splitright" >> $HOME/.vimrc
# Plug
echo >> $HOME/.vimrc
echo "call plug#begin('~/.vim/plugged')" >> $HOME/.vimrc
echo >> $HOME/.vimrc
echo "Plug 'https://github.com/NLKNguyen/papercolor-theme'" >> $HOME/.vimrc
echo >> $HOME/.vimrc
echo "call plug#end()" >> $HOME/.vimrc
echo >> $HOME/.vimrc
# Color Theme
echo "set t_Co=256" >> $HOME/.vimrc
echo "set background=dark" >> $HOME/.vimrc
echo "colorscheme PaperColor" >> $HOME/.vimrc
# Keyboard Shortcuts remap
echo >> $HOME/.vimrc
echo "tnoremap <Esc><Esc> <C-\><C-n>" >> $HOME/.vimrc
echo "tnoremap <C-h> <C-\><C-n><C-w>h" >> $HOME/.vimrc
echo "tnoremap <C-j> <C-\><C-n><C-w>j" >> $HOME/.vimrc
echo "tnoremap <C-k> <C-\><C-n><C-w>k" >> $HOME/.vimrc
echo "tnoremap <C-l> <C-\><C-n><C-w>l" >> $HOME/.vimrc
echo "nnoremap <C-h> <C-w>h" >> $HOME/.vimrc
echo "nnoremap <C-j> <C-w>j" >> $HOME/.vimrc
echo "nnoremap <C-k> <C-w>k" >> $HOME/.vimrc
echo "nnoremap <C-l> <C-w>l" >> $HOME/.vimrc
echo "cnoremap W w !sudo tee % > /dev/null" >> $HOME/.vimrc

# SETTINGS/nvim
mkdir -p $HOME/.config/nvim
cat $HOME/.vimrc > $HOME/.config/nvim/init.vim
sed -i 's/\~\/\.vim\/plugged/\~\/\.local\/share\/nvim\/plugged/' $HOME/.config/nvim/init.vim 
echo "vnoremap <C-c> \"+y" >> $HOME/.config/nvim/init.vim
echo "nnoremap <C-v> o<Esc>\"+p0" >> $HOME/.config/nvim/init.vim
sed -i '5 i set nohlsearch' $HOME/.config/nvim/init.vim
sed -i '13 i set nomodeline' $HOME/.config/nvim/init.vim

# SETTINGS/vimrc 2 (different from nvim/init.vim)
echo "vnoremap <C-c> :w !xclip -sel c<CR><CR>" >> $HOME/.vimrc
echo "vnoremap <C-v> :r !xclip -sel c -o<CR>" >> $HOME/.vimrc

# SETTINGS/vim/PlugInstall
vim -c PlugInstall -c qa

# SETTINGS/nvim/PlugInstall
nvim -c PlugInstall -c qa

# SETTINGS/.profile
# add $HOME/bin to PATH if it exists
if [ ! -f $HOME/.profile ] || [ $(wc -l < $HOME/.profile) -eq 0 ]; then
    echo -e "if [ -d \$HOME/bin ]; then" >> $HOME/.profile
    echo -e "    export PATH=\$PATH:\$HOME/bin" >> $HOME/.profile
    echo "fi" >> $HOME/.profile
fi
# add "." to PATH to allow running executable scripts directly
echo >> $HOME/.profile
echo 'export PATH=\.:$PATH' >> $HOME/.profile
# export DISPLAY=:0 for ssh commands
echo >> $HOME/.profile
echo 'export DISPLAY=":0"' >> $HOME/.profile
# nvm
echo >> $HOME/.profile
#echo '# nvm' >> $HOME/.profile
#echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.profile
#echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # this loads nvm' >> $HOME/.profile
#echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # this loads nvm bash_completion' >> $HOME/.profile

# SETTINGS/aliases
if [ -f $HOME/.bash_aliases ]; then
    cp $HOME/.bash_aliases $HOME/.bash_aliases.bak
    > $HOME/.bash_aliases
fi

echo "alias xclip='xclip -selection c'" >> $HOME/.bash_aliases
echo "alias subl='xrun subl'" >> $HOME/.bash_aliases
echo "alias smerge='xrun smerge'" >> $HOME/.bash_aliases
echo "alias tm='tmux attach -d'" >> $HOME/.bash_aliases
echo "alias dff='duf -only local'" >> $HOME/.bash_aliases
echo "alias kodi='xrun caffeinate kodi'" >> $HOME/.bash_aliases

# SETTINGS/Wake on LAN
sudo bash -c 'echo -e "[Unit]\n" >> /etc/systemd/system/wol@.service'
sudo bash -c 'echo -e "Description=Wake-on-LAN for %i\n" >> /etc/systemd/system/wol@.service'
sudo bash -c 'echo -e "Requires=network.target\n" >> /etc/systemd/system/wol@.service'
sudo bash -c 'echo -e "After=network.target\n\n" >> /etc/systemd/system/wol@.service'
sudo bash -c 'echo -e "[Service]\n" >> /etc/systemd/system/wol@.service'
sudo bash -c 'echo -e "ExecStart=/sbin/ethtool -s %i wol g\n" >> /etc/systemd/system/wol@.service'
sudo bash -c 'echo -e "Type=oneshot\n\n" >> /etc/systemd/system/wol@.service'
sudo bash -c 'echo -e "[Install]\n" >> /etc/systemd/system/wol@.service'
sudo bash -c 'echo -e "WantedBy=multi-user.target\n" >> /etc/systemd/system/wol@.service'
NI="$(ip link show | head -3 | tail -1 | tr -s ' ' | cut -d ' ' -f 2 | tr -d ':')"
sudo systemctl enable wol@${NI}

# SETTINGS/Folders and Links

# ~/bin/
mkdir $HOME/bin/
if [ $BINARY_LINKS == "y" ]; then
    # Scripts
    cp "$SCRIPTS_FOLDER/currency-converter/eur.sh" $HOME/bin/eur
    cp "$SCRIPTS_FOLDER/currency-converter/usd.sh" $HOME/bin/usd
    cp "$SCRIPTS_FOLDER/currency-converter/gbp.sh" $HOME/bin/gbp
    cp "$SCRIPTS_FOLDER/currency-converter/ron.sh" $HOME/bin/ron
    cp "$SCRIPTS_FOLDER/rickrollrc-master/roll.sh" $HOME/bin/roll
    cp "$SCRIPTS_FOLDER/weather.sh" $HOME/bin/weather
    cp "$SCRIPTS_FOLDER/sw.sh" $HOME/bin/sw
    cp "$SCRIPTS_FOLDER/to.sh" $HOME/bin/to
    cp "$SCRIPTS_FOLDER/empty-trash.sh" $HOME/bin/empty-trash
    cp "$SCRIPTS_FOLDER/clean-usb.sh" $HOME/bin/clean-usb
    cp "$SCRIPTS_FOLDER/clean-usb-fat32.sh" $HOME/bin/clean-usb-fat32
    cp "$SCRIPTS_FOLDER/bookmark.sh" $HOME/bin/bk
    cp "$SCRIPTS_FOLDER/bookmark-streamdeck.sh" $HOME/bin/bookmark-streamdeck
    cp "$SCRIPTS_FOLDER/xopen.sh" $HOME/bin/xopen
    cp "$SCRIPTS_FOLDER/xrun.sh" $HOME/bin/xrun
    cp "$SCRIPTS_FOLDER/websearch.py" $HOME/bin/websearch
    cp "$SCRIPTS_FOLDER/websearch.py" $HOME/bin/search
    cp "$SCRIPTS_FOLDER/websearch.py" $HOME/bin/s
    cp "$SCRIPTS_FOLDER/wordwrap-paste.sh" $HOME/bin/wp
    cp "$SCRIPTS_FOLDER/sound-restart.sh" $HOME/bin/sound-restart
    cp "$SCRIPTS_FOLDER/sound-restart.sh" $HOME/bin/sr
    cp "$SCRIPTS_FOLDER/search-replace.sh" $HOME/bin/search-replace
    cp "$SCRIPTS_FOLDER/goto.sh" $HOME/bin/goto
    cp "$SCRIPTS_FOLDER/work-done.sh" $HOME/bin/work-done
    cp "$SCRIPTS_FOLDER/tolower.py" $HOME/bin/tolower
    cp "$SCRIPTS_FOLDER/toupper.py" $HOME/bin/toupper
    cp "$SCRIPTS_FOLDER/insert-address.sh" $HOME/bin/insert-address
    cp "$SCRIPTS_FOLDER/showmyip.sh" $HOME/bin/showmyip
    cp "$SCRIPTS_FOLDER/worldclock.sh" $HOME/bin/worldclock
    cp "$SCRIPTS_FOLDER/check-connection.sh" $HOME/bin/check-connection
    cp "$SCRIPTS_FOLDER/output-FiiO.sh" $HOME/bin/output-FiiO
    cp "$SCRIPTS_FOLDER/output-Schiit.sh" $HOME/bin/output-Schiit
    cp "$SCRIPTS_FOLDER/gkraken-startup.sh" $HOME/bin/gkraken-startup
    cp "$SCRIPTS_FOLDER/streamdeck-startup.sh" $HOME/bin/streamdeck-startup
    cp "$SCRIPTS_FOLDER/start-qbittorrent.sh" $HOME/bin/start-qbittorrent
    cp "$SCRIPTS_FOLDER/startup.sh" $HOME/bin/startup
    ln -s "$CODE_FOLDER/Useful/Heimdallr/trackall.py" $HOME/bin/trackall
    # Cmus
    cp "$SCRIPTS_FOLDER/cmus-lyrics-master/cmus-lyrics" $HOME/bin/lyrics
    cp "$SCRIPTS_FOLDER/cmus-local/pp-local" $HOME/bin/pp-local
    cp "$SCRIPTS_FOLDER/cmus-local/stop-local" $HOME/bin/stop-local
    cp "$SCRIPTS_FOLDER/cmus-local/next-local" $HOME/bin/next-local
    cp "$SCRIPTS_FOLDER/cmus-local/prev-local" $HOME/bin/prev-local
    cp "$SCRIPTS_FOLDER/cmus-local/set-local" $HOME/bin/set-local
    cp "$SCRIPTS_FOLDER/cmus-local/pp-remote" $HOME/bin/pp-remote
    cp "$SCRIPTS_FOLDER/cmus-local/stop-remote" $HOME/bin/stop-remote
    cp "$SCRIPTS_FOLDER/cmus-local/next-remote" $HOME/bin/next-remote
    cp "$SCRIPTS_FOLDER/cmus-local/prev-remote" $HOME/bin/prev-remote
    cp "$SCRIPTS_FOLDER/cmus-local/set-remote" $HOME/bin/set-remote
    cp "$SCRIPTS_FOLDER/cmus-local/vol" $HOME/bin/vol
    cp "$SCRIPTS_FOLDER/cmus-local/shuffle.sh" $HOME/bin/shuffle
    cp "$SCRIPTS_FOLDER/cmus-local/seek.sh" $HOME/bin/seek
    cp "$SCRIPTS_FOLDER/cmus-local/playlist.sh" $HOME/bin/playlist     
    cp "$SCRIPTS_FOLDER/cmus-local/playlists.sh" $HOME/bin/playlists     
    cp "$SCRIPTS_FOLDER/cmus-local/song.sh" $HOME/bin/song            
    cp "$SCRIPTS_FOLDER/cmus-local/player-start.sh" $HOME/bin/player-start
    cp "$SCRIPTS_FOLDER/cmus-local/cmuscontrols.sh" $HOME/bin/cmuscontrols
    cp "$SCRIPTS_FOLDER/mute-FiiO.sh" $HOME/bin/mute-FiiO
    cp "$SCRIPTS_FOLDER/mute-Schiit.sh" $HOME/bin/mute-Schiit
    
    # Binaries
    cp "$BINARIES_FOLDER/milestokm" $HOME/bin/milestokm
    cp "$BINARIES_FOLDER/kmtomiles" $HOME/bin/kmtomiles
    cp "$BINARIES_FOLDER/ftin" $HOME/bin/ftin
    cp "$BINARIES_FOLDER/fahr" $HOME/bin/fahr
    cp "$BINARIES_FOLDER/cel" $HOME/bin/cel
    cp "$BINARIES_FOLDER/cm" $HOME/bin/cm
    cp "$BINARIES_FOLDER/stats" $HOME/bin/stats
    cp "$BINARIES_FOLDER/word-frequency" $HOME/bin/word-frequency
    cp "$BINARIES_FOLDER/rthreads.py" $HOME/bin/rthreads
fi

# Folders
if [ $FOLDER_LINKS == "y" ]; then
    rmdir $HOME/Documents 2> /dev/null
    ln -s "$DOCUMENTS_FOLDER" $HOME/Documents
    rmdir $HOME/Music 2> /dev/null
    ln -s "$MUSIC_FOLDER" $HOME/Music
    rmdir $HOME/Pictures 2> /dev/null
    ln -s "$PICTURES_FOLDER" $HOME/Pictures
    rmdir $HOME/Videos 2> /dev/null
    ln -s "$VIDEOS_FOLDER" $HOME/Videos
    rmdir $HOME/Downloads 2> /dev/null
    ln -s "$DOWNLOADS_FOLDER" $HOME/Downloads
    ln -s "$CODE_FOLDER" $HOME/Code
    ln -s "$SCRIPTS_FOLDER" $HOME/Scripts
    ln -s "$SCRIPTS_FOLDER" $HOME/Scripts
    ln -s "$SOFTWARE_FOLDER" $HOME/Kituri
fi

# SETTINGS/Autostart

which $DEFAULT_TERMINAL_EMULATOR > /dev/null || export DEFAULT_TERMINAL_EMULATOR=gnome-terminal
mkdir -p $HOME/.config/autostart

# Terminal
> $HOME/.config/autostart/terminology.desktop
bash -c 'echo "[Desktop Entry]" >> $HOME/.config/autostart/terminology.desktop'
bash -c 'echo "Type=Application" >> $HOME/.config/autostart/terminology.desktop'
bash -c 'echo "Exec=$DEFAULT_TERMINAL_EMULATOR -g 140x48 -e tmux -2" >> $HOME/.config/autostart/terminology.desktop'
bash -c 'echo "Hidden=false" >> $HOME/.config/autostart/terminology.desktop'
bash -c 'echo "NoDisplay=false" >> $HOME/.config/autostart/terminology.desktop'
bash -c 'echo "X-GNOME-Autostart-enabled=true" >> $HOME/.config/autostart/terminology.desktop'
bash -c 'echo "Name[en_US]=Terminal" >> $HOME/.config/autostart/terminology.desktop'
bash -c 'echo "Name=terminal" >> $HOME/.config/autostart/terminology.desktop'
bash -c 'echo "Comment[en_US]=Open terminal at startup" >> $HOME/.config/autostart/terminology.desktop'
bash -c 'echo "Comment=open terminal at startup" >> $HOME/.config/autostart/terminology.desktop'

# CmusControls
> $HOME/.config/autostart/CmusControls.py.desktop
bash -c 'echo "[Desktop Entry]" >> $HOME/.config/autostart/CmusControls.py.desktop'
bash -c 'echo "Type=Application" >> $HOME/.config/autostart/CmusControls.py.desktop'
bash -c 'echo "Exec=/mnt/raid1/Code/Useful/Gamepad/CmusControls.py" >> $HOME/.config/autostart/CmusControls.py.desktop'
bash -c 'echo "Hidden=false" >> $HOME/.config/autostart/CmusControls.py.desktop'
bash -c 'echo "NoDisplay=false" >> $HOME/.config/autostart/CmusControls.py.desktop'
bash -c 'echo "X-GNOME-Autostart-enabled=true" >> $HOME/.config/autostart/CmusControls.py.desktop'
bash -c 'echo "Name[en_US]=Cmus PS4 controls" >> $HOME/.config/autostart/CmusControls.py.desktop'
bash -c 'echo "Name=Cmus PS4 controls" >> $HOME/.config/autostart/CmusControls.py.desktop'
bash -c 'echo "Comment[en_US]=" >> $HOME/.config/autostart/CmusControls.py.desktop'
bash -c 'echo "Comment=" >> $HOME/.config/autostart/CmusControls.py.desktop'

# GKraken
> $HOME/.config/autostart/gkraken-startup.desktop
bash -c 'echo "[Desktop Entry]" >> $HOME/.config/autostart/gkraken-startup.desktop'
bash -c 'echo "Type=Application" >> $HOME/.config/autostart/gkraken-startup.desktop'
bash -c 'echo "Exec=/home/mercury/bin/gkraken-startup" >> $HOME/.config/autostart/gkraken-startup.desktop'
bash -c 'echo "Hidden=false" >> $HOME/.config/autostart/gkraken-startup.desktop'
bash -c 'echo "NoDisplay=false" >> $HOME/.config/autostart/gkraken-startup.desktop'
bash -c 'echo "X-GNOME-Autostart-enabled=true" >> $HOME/.config/autostart/gkraken-startup.desktop'
bash -c 'echo "Name[en_US]=GKraken" >> $HOME/.config/autostart/gkraken-startup.desktop'
bash -c 'echo "Name=GKraken" >> $HOME/.config/autostart/gkraken-startup.desktop'
bash -c 'echo "Comment[en_US]=" >> $HOME/.config/autostart/gkraken-startup.desktop'
bash -c 'echo "Comment=" >> $HOME/.config/autostart/gkraken-startup.desktop'

# streamdeck-startup.desktop
> $HOME/.config/autostart/streamdeck-startup.desktop
bash -c 'echo "[Desktop Entry]" >> $HOME/.config/autostart/streamdeck-startup.desktop'
bash -c 'echo "Type=Application" >> $HOME/.config/autostart/streamdeck-startup.desktop'
bash -c 'echo "Exec=/home/mercury/bin/streamdeck-startup" >> $HOME/.config/autostart/streamdeck-startup.desktop'
bash -c 'echo "Hidden=false" >> $HOME/.config/autostart/streamdeck-startup.desktop'
bash -c 'echo "NoDisplay=false" >> $HOME/.config/autostart/streamdeck-startup.desktop'
bash -c 'echo "X-GNOME-Autostart-enabled=true" >> $HOME/.config/autostart/streamdeck-startup.desktop'
bash -c 'echo "Name[en_US]=StreamDeck UI" >> $HOME/.config/autostart/streamdeck-startup.desktop'
bash -c 'echo "Name=StreamDeck UI" >> $HOME/.config/autostart/streamdeck-startup.desktop'
bash -c 'echo "Comment[en_US]=" >> $HOME/.config/autostart/streamdeck-startup.desktop'
bash -c 'echo "Comment=" >> $HOME/.config/autostart/streamdeck-startup.desktop'

# trackall.desktop
> $HOME/.config/autostart/trackall.desktop
bash -c 'echo "[Desktop Entry]" >> $HOME/.config/autostart/trackall.desktop'
bash -c 'echo "Type=Application" >> $HOME/.config/autostart/trackall.desktop'
bash -c 'echo "Exec=/mnt/raid1/Code/Useful/Heimdallr/trackall_wait.py" >> $HOME/.config/autostart/trackall.desktop'
bash -c 'echo "Hidden=false" >> $HOME/.config/autostart/trackall.desktop'
bash -c 'echo "NoDisplay=false" >> $HOME/.config/autostart/trackall.desktop'
bash -c 'echo "X-GNOME-Autostart-enabled=true" >> $HOME/.config/autostart/trackall.desktop'
bash -c 'echo "Name[en_US]=Price/Availability tracker" >> $HOME/.config/autostart/trackall.desktop'
bash -c 'echo "Name=Price/Availability tracker" >> $HOME/.config/autostart/trackall.desktop'
bash -c 'echo "Comment[en_US]=" >> $HOME/.config/autostart/trackall.desktop'
bash -c 'echo "Comment=" >> $HOME/.config/autostart/trackall.desktop'

# startup.desktop
> $HOME/.config/autostart/startup.desktop
bash -c 'echo "[Desktop Entry]" >> $HOME/.config/autostart/startup.desktop'
bash -c 'echo "Type=Application" >> $HOME/.config/autostart/startup.desktop'
bash -c 'echo "Exec=/home/mercury/bin/startup" >> $HOME/.config/autostart/startup.desktop'
bash -c 'echo "Hidden=false" >> $HOME/.config/autostart/startup.desktop'
bash -c 'echo "NoDisplay=false" >> $HOME/.config/autostart/startup.desktop'
bash -c 'echo "X-GNOME-Autostart-enabled=true" >> $HOME/.config/autostart/startup.desktop'
bash -c 'echo "Name[en_US]=Startup" >> $HOME/.config/autostart/startup.desktop'
bash -c 'echo "Name=Startup" >> $HOME/.config/autostart/startup.desktop'
bash -c 'echo "Comment[en_US]=" >> $HOME/.config/autostart/startup.desktop'
bash -c 'echo "Comment=Commits and no trash" >> $HOME/.config/autostart/startup.desktop'


# SETTINGS/Cosmetics

# mc skin
mkdir -p $HOME/.local/share/mc/skins/
cp "$(find $HOME -name darkcourses_green.ini 2> /dev/null | head -1)" $HOME/.local/share/mc/skins/
gnome-terminal -x mc
echo "Please exit the mc instance that opened, using File->Exit."
read -N 1000000 -t 0.001 # Clear input
echo "Press ENTER to confirm."
read CONFIRMATION
sed -i 's/skin=default/skin=darkcourses_green/' $HOME/.config/mc/ini 

# SETTINGS/Wine Tweaks
sudo sed -i 's/#DefaultLimitNOFILE=.*/DefaultLimitNOFILE=1048576/' /etc/systemd/system.conf 
sudo sed -i 's/#DefaultLimitNOFILE=.*/DefaultLimitNOFILE=1048576/' /etc/systemd/user.conf 

# SETTINGS/ssh
ssh-keygen -t rsa -b 4096 

# SETTINGS/ssh-copy-id to phone
read -N 1000000 -t 0.001 # Clear input 
echo -n "Copy ssh public key to phone? (Y/n): "
read SSH_COPY_PHONE
if [ "$SSH_COPY_PHONE" == "y" ] || [ "$SSH_COPY_PHONE" == "Y" ] || [ "$SSH_COPY_PHONE" == "" ]; then
	read -N 1000000 -t 0.001 # Clear input 
	echo -n "Is your phone connected? (y/N): "
	read PHONE_CONNECTED
	if [ "$PHONE_CONNECTED" == "y" ] || [ "$PHONE_CONNECTED" == "Y" ]; then
	    read -N 1000000 -t 0.001 # Clear input
	    echo -n "Enter your phone IP (default $DEFAULT_PHONE_IP): "
	    read PHONE_IP
	    if [ "$PHONE_IP" == "" ]; then
	        PHONE_IP="$DEFAULT_PHONE_IP"
	    fi
	    ssh-copy-id -p 8022 -i $HOME/.ssh/id_rsa $PHONE_IP
	    echo "alias phone='ssh -p 8022 $PHONE_IP'" >> $HOME/.bash_aliases
	else
	    echo "alias phone='ssh -p 8022 $DEFAULT_PHONE_IP'" >> $HOME/.bash_aliases
	fi
fi

# SETTINGS/Privacy
gsettings set org.gnome.desktop.privacy remember-recent-files false

# SETTINGS/hostname
sudo -E bash -c "echo $HOSTNAME > /etc/hostname"

# SETTINGS/Disable tracker
#systemctl --user mask tracker-store.service tracker-miner-fs.service tracker-miner-rss.service tracker-extract.service tracker-miner-apps.service tracker-writeback.service
#tracker reset --hard

# SETTINGS/Kernel modules

# SETTINGS/Kernel modules/Enable Vulkan on Radeon R9 200/300 series (updates kernel, so this is last)
#echo "blacklist radeon" | sudo tee --append /etc/modprobe.d/blacklist.conf
#echo "options amdgpu si_support=1 cik_support=1" | sudo tee --append /etc/modprobe.d/amdgpu.conf

# SETTINGS/Kernel modules/Function keys for Varmilo Keyboard
echo "options hid_apple fnmode=2" | sudo tee --append /etc/modprobe.d/hid_apple.conf

# SETTINGS/Kernel modules/update-initramfs
sudo update-initramfs -u

# DONE
echo -e "\nDone!"
read -N 1000000 -t 0.001 # Clear input 
echo -n "Restart your system now? (Y/n): "
read DONE
if [ "$DONE" == "n" ] || [ "$DONE" == "N" ]; then
    exit 0
else
    sudo reboot
fi

