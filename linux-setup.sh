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
export SCRIPTS_FOLDER=$HOME/Dropbox/Scripts
export BINARIES_FOLDER=$HOME/Dropbox/bin
export CODE_FOLDER=$HOME/Dropbox/Code
export RAMDISK_MOUNT_POINT=/mnt/ramdisk
export UBUNTU_CODENAME="$(lsb_release -a 2> /dev/null | grep Codename | tr -d [:space:] | cut -d: -f2)"
export DEFAULT_TERMINAL_EMULATOR=/usr/bin/terminology
export CURRENT_USER=$USER
export HOSTNAME=forge
export DEFAULT_PHONE_IP=192.168.0.102

# ONLINE SOURCES

ZSH_SETUP="https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
VIRTUALBOX="https://download.virtualbox.org/virtualbox/6.1.2/virtualbox-6.1_6.1.2-135662~Ubuntu~eoan_amd64.deb"
VBOX_EXTENSION_PACK="https://download.virtualbox.org/virtualbox/6.0.8/Oracle_VM_VirtualBox_Extension_Pack-6.0.8.vbox-extpack"
TEAMSPEAK="http://dl.4players.de/ts/releases/3.2.2/TeamSpeak3-Client-linux_amd64-3.2.2.run"
DISCORD="https://discordapp.com/api/download?platform=linux&format=deb"
TEAMVIEWER="https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"
ATOM="https://atom.io/download/deb"
DMD="http://downloads.dlang.org/releases/2.x/2.087.0/dmd_2.087.0-0_amd64.deb"
SKYPE="https://go.skype.com/skypeforlinux-64.deb"
TOR_BROWSER="https://dist.torproject.org/torbrowser/9.0.4/tor-browser-linux64-9.0.4_en-US.tar.xz"
CLION="https://download.jetbrains.com/cpp/CLion-2019.3.2.tar.gz"
PHPSTORM="https://download.jetbrains.com/webide/PhpStorm-2019.3.1.tar.gz"
WEBSTORM="https://download.jetbrains.com/webstorm/WebStorm-2019.3.1.tar.gz"
PYCHARM="https://download.jetbrains.com/python/pycharm-professional-2019.3.1.tar.gz"
INTELLIJ="https://download.jetbrains.com/idea/ideaIU-2019.3.1.tar.gz"
GIT_KRAKEN="https://release.axocdn.com/linux/gitkraken-amd64.tar.gz"
POSTMAN="https://dl.pstmn.io/download/latest/linux64"
MYSQL_WORKBENCH="https://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb"
# Gnome Shell Extensions
REFRESH_WIFI="https://extensions.gnome.org/extension-data/refresh-wifikgshank.net.v11.shell-extension.zip"
PLACES_STATUS_INDICATOR="https://extensions.gnome.org/extension-data/places-menugnome-shell-extensions.gcampax.github.com.v45.shell-extension.zip"

# ------------------------------------------------------------------------------------------------------------------------------


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

# Graphics - Nvidia or AMD
#read -N 1000000 -t 0.001 # Clear input
#echo -n "Nvidia or AMD? (n/a): " 
#read GRAPHICS_CARD
#while [ "$GRAPHICS_CARD" != "g" ] && [ "$GRAPHICS_CARD" != "k" ]; do
#    read -N 1000000 -t 0.001 # Clear input
#echo -n "Please enter 'n' or 'a': " 
#    read GRAPHICS_CARD
#done

# Links to custom binaries and scripts (~/bin)
read -N 1000000 -t 0.001 # Clear input
echo -n "Create links to custom binaries and scripts? (Y/n): "
read BINARY_LINKS
if [ "$BINARY_LINKS" == "y" ] || [ "$BINARY_LINKS" == "Y" ] || [ "$BINARY_LINKS" == "" ]; then
    BINARY_LINKS="y"
fi

# Links to folders
read -N 1000000 -t 0.001 # Clear input
echo -n "Create links to custom binaries and scripts? (Y/n): "
read FOLDER_LINKS
if [ "$FOLDER_LINKS" == "y" ] || [ "$FOLDER_LINKS" == "Y" ] || [ "$FOLDER_LINKS" == "" ]; then
    FOLDER_LINKS="y"
done

# ------------------------------------------------------------------------------------------------------------------------------


# REPOSITORIES

# REPOSITORIES/Sublime Text
wget -qO- https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo bash -c 'echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublime-text.list'

# REPOSITORIES/Wine
wget -nc https://dl.winehq.org/wine-builds/winehq.key -O- | sudo apt-key add -
sudo apt-add-repository -y "deb https://dl.winehq.org/wine-builds/ubuntu/ $UBUNTU_CODENAME main"

# REPOSITORIES/Lutris
sudo add-apt-repository -y ppa:lutris-team/lutris

# REPOSITORIES/webupd8
sudo add-apt-repository -y ppa:nilarimogard/webupd8

# REPOSITORIES/Typora
wget -qO- https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository -y 'deb https://typora.io/linux ./'


# INSTALL

# INSTALL/add architecture
sudo dpkg --add-architecture i386

# INSTALL/apt

sudo apt update -y
# Remove packages installed by default
# Vivaldi Browser
sudo apt purge -y vivaldi-stable
sudo apt purge -y vivaldi-config-feren
sudo apt purge -y feren-vivaldi-theme
# Cleanup
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
sudo apt install -y anacron
sudo apt install -y errno
sudo apt install -y pstree
sudo apt install -y finger
sudo apt install -y xclip
sudo apt install -y gpaste
sudo apt install -y gnome-shell-extensions-gpaste
sudo apt install -y libnotify-bin
sudo apt install -y rwho
sudo apt install -y openssh-server
sudo apt install -y sshfs
sudo apt install -y nnn
sudo apt install -y w3m
sudo apt install -y postfix
sudo apt install -y mailutils
sudo apt install -y gparted
sudo apt install -y woeusb
sudo apt install -y psensor
sudo apt install -y gkrellm
sudo apt install -y g++
sudo apt install -y ldc
sudo apt install -y openjdk-14-jdk
sudo apt install -y php
sudo apt install -y python3-lxml
sudo apt install -y git
sudo apt install -y cmake
sudo apt install -y cmake-gui
sudo apt install -y sublime-text
sudo apt install -y sublime-merge
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
sudo apt install -y dia
sudo apt install -y ttf-mscorefonts-installer
sudo apt install -y fonts-inconsolata
sudo apt install -y pandoc
sudo apt install -y texlive
sudo apt install -y img2pdf
sudo apt install -y fbreader
sudo apt install -y typora
sudo apt install -y cmus
sudo apt install -y audacious
sudo apt install -y audacious-plugins
sudo apt install -y vlc
sudo apt install -y finch
sudo apt install -y alacarte
sudo apt install -y nautilus-dropbox
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
# Wine dependencies
sudo apt install -y libgnutls30:i386 
sudo apt install -y libldap-2.4-2:i386 
sudo apt install -y libgpg-error0:i386 
sudo apt install -y libsqlite3-0:i386

#
sudo apt install -y --install-recommends winehq-stable
sudo apt install -y playonlinux
sudo apt install -y lutris
sudo apt install -y steam
sudo apt install -y npm
sudo apt install -y flatpak
sudo apt install -y gnome-software-plugin-flatpak

# INSTALL/apt/gnome or kde
if [ "$X_VERSION" == "g" ]; then
    sudo apt install -y doublecmd-gtk
    sudo apt install -y gnome-tweaks

    # Gnome Extensions
    mkdir -p $HOME/.local/share/gnome-shell/extensions/ && cd $_
    # Gnome Extensions/Refresh WIFI
    mkdir -p $HOME/.local/share/gnome-shell/extensions/ && cd $_
    if [ $? -eq 0 ]; then
        wget -O refresh-wifi.zip $REFRESH_WIFI
        unzip refresh-wifi.zip
        rm refresh-wifi.zip
        UUID=$(grep 'uuid' 'metadata.json' | tr -d '," ' | cut -d: -f3) 
        mkdir $UUID && mv * $UUID 2> /dev/null
    fi
    # Gnome Extensions/Places Status Indicator
    mkdir -p $HOME/.local/share/gnome-shell/extensions/ && cd $_
    if [ $? -eq 0 ]; then
        wget -O places-status-indicator.zip $PLACES_STATUS_INDICATOR
        unzip places-status-indicator.zip
        rm places-status-indicator.zip
        UUID=$(grep 'uuid' 'metadata.json' | tr -d '," ' | cut -d: -f3) 
        mkdir $UUID && mv * $UUID 2> /dev/null
    fi
    cd $RUN_FOLDER
else 
    sudo apt install -y doublecmd-qt
fi

# INSTALL/apt/Nvidia or AMD
#if [ "$GRAPHICS_CARD" == "n" ]; then
#else
#fi

# INSTALL/npm
sudo npm install jsonlint -g

# INSTALL/nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

# INSTALL/flatpak

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# UberWriter
echo '#!/bin/bash' > install-uberwriter.sh
echo 'flatpak install -y flathub de.wolfvollprecht.UberWriter' >> install-uberwriter.sh
echo 'flatpak install -y flathub de.wolfvollprecht.UberWriter.Plugin.TexLive' >> install-uberwriter.sh
chmod +x install-uberwriter.sh
echo "Run install-uberwriter.sh after reboot." 1>&2

# INSTALL/Download

# INSTALL/Download/VirtualBox
wget -O virtualbox.deb "$VIRTUALBOX" 2> /dev/null # get rid of excessive output
sudo dpkg -i virtualbox.deb || sudo apt install -f -y
rm -f virtualbox.deb
wget $VBOX_EXTENSION_PACK 2> /dev/null  # get rid of excessive output
echo "Virtualbox Extension Pack downloaded, install manually." 1>&2

# INSTALL/Download/TeamSpeak
wget -O teamspeak.run "$TEAMSPEAK" 2> /dev/null   # get rid of excessive output
chmod +x teamspeak.run
./teamspeak.run
rm -f teamspeak.run
sudo mv TeamSpeak* /opt/
echo "TeamSpeak: create a lanucher pointing to /opt/TeamSpeak3-Client-linux_amd64/ts3client_runscript.sh" 1>&2

# INSTALL/Download/Discord
wget -O discord.deb "$DISCORD" 2> /dev/null   
sudo dpkg -i discord.deb || sudo apt install -f -y
rm -f discord.deb

# INSTALL/Download/TeamViewer
wget -O teamviewer.deb "$TEAMVIEWER" 2> /dev/null   
sudo dpkg -i teamviewer.deb || sudo apt install -f -y
rm -f teamviewer.deb

# INSTALL/Download/Atom
wget -O atom.deb "$ATOM" 2> /dev/null 
sudo dpkg -i atom.deb || sudo apt install -f -y
rm -f atom.deb

# INSTALL/Download/DMD
wget -O dmd.deb "$DMD" 2> /dev/null    
sudo dpkg -i dmd.deb || sudo apt install -f -y
rm -f dmd.deb

# INSTALL/Download/Clion
wget -O clion.tar.gz "$CLION" 2> /dev/null 
tar -xzvf clion.tar.gz
rm -rf clion.tar.gz
sudo mv clion* /opt/

# INSTALL/Download/PyCharm
wget -O pycharm.tar.gz "$PYCHARM" 2> /dev/null 
tar -xzvf pycharm.tar.gz
rm -rf pycharm.tar.gz
sudo mv pycharm* /opt/

# INSTALL/Download/IntelliJ IDEA
wget -O ideaiu.tar.gz "$INTELLIJ" 2> /dev/null 
tar -xzvf ideaiu.tar.gz
rm -rf ideaiu.tar.gz
sudo mv idea-IU* /opt/

# INSTALL/Download/WebStorm
wget -O webstorm.tar.gz "$WEBSTORM" 2> /dev/null 
tar -xzvf webstorm.tar.gz
rm -rf webstorm.tar.gz
sudo mv WebStorm* /opt/

# INSTALL/Download/PhpStorm
wget -O phpstorm.tar.gz "$PHPSTORM" 2> /dev/null 
tar -xzvf phpstorm.tar.gz
rm -rf phpstorm.tar.gz
sudo mv PhpStorm* /opt/

# INSTALL/Download/GitKraken
wget -O gitkraken.tar.gz "$GIT_KRAKEN" 2> /dev/null    
tar -xzvf gitkraken.tar.gz
rm -f gitkraken.tar.gz
sudo mv gitkraken* /opt/

# INSTALL/Download/Postman
wget -O postman.tar.gz "$POSTMAN" 2> /dev/null 
tar -xzvf postman.tar.gz
rm -rf postman.tar.gz
sudo mv Postman /opt/

# INSTALL/Download/Mysql Workbench
wget -O mysql-workbench.deb "$MYSQL_WORKBENCH" 2> /dev/null    
sudo dpkg -i mysql-workbench.deb || sudo apt install -f -y
rm -f mysql-workbench.deb

# INSTALL/Download/Skype
wget -O skype.deb "$SKYPE" 2> /dev/null    
sudo dpkg -i skype.deb || sudo apt install -f -y
rm -f skype.deb

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
sudo -E bash -c 'echo "# $CURRENT_USER" >> /etc/sysctl.conf'
sudo bash -c 'echo "# Reduce swap tendency" >> /etc/sysctl.conf'
sudo bash -c 'echo "vm.swappiness = 10" >> /etc/sysctl.conf'

# SETTINGS/Email
# Required software already installed in the INSTALL/apt section
# Configure Authetication
export SMTP_SERVER='[smtp.gmail.com]:587'
read -N 1000000 -t 0.001 # Clear input
echo "Enter the Email address for your account: "
read EMAIL
echo "Enter your password: "
read -s PASSWORD
echo "Confirm your password: "
read -s PASSWORD2
while [ "$PASSWORD" != "$PASSWORD2" ]; do
    read -N 1000000 -t 0.001 # Clear input
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
# Enable Postfix on boot (may not be needed)
sudo systemctl enable postfix.service
# Less secure apps have to be enabled in Gmail
echo "Less secure apps have to be enabled in Gmail: https://myaccount.google.com/lesssecureapps" 1>&2
# Test Email
echo "Linux Email configuration completed." | mail -s "Linux Email" "$EMAIL"
unset EMAIL

# SETTINGS/Set hardware clock to local time (if you are using dual-boot with Windows)
# timedatectl set-local-rtc 1 --adjust-system-clock

# SETTINGS/Default Editor
sudo update-alternatives --set editor /usr/bin/nvim

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
echo 'source $HOME/.bash_aliases' >> $HOME/.zshrc
unset PASSWORD

# SETTINGS/Default Terminal Emulator
which $DEFAULT_TERMINAL_EMULATOR > /dev/null || export DEFAULT_TERMINAL_EMULATOR=gnome-terminal
sudo update-alternatives --set x-terminal-emulator $DEFAULT_TERMINAL_EMULATOR

# SETTINGS/grub
ed -i 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=2/' /etc/default/grub 
sudo bash -c 'echo "GRUB_RECORDFAIL_TIMEOUT=$GRUB_TIMEOUT" >> /etc/default/grub'
sudo update-grub
# Grub btrfs bug workaround
# sudo grub-editenv create  # seems unnecessary for now

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
# export DISPLAY=:0 for ssh commands
echo >> $HOME/.profile
echo 'export DISPLAY=":0"' >> $HOME/.profile
# nvm
echo >> $HOME/.profile
echo '# nvm' >> $HOME/.profile
echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.profile
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # this loads nvm' >> $HOME/.profile
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # this loads nvm bash_completion' >> $HOME/.profile

# SETTINGS/aliases
if [ -f $HOME/.bash_aliases ]; then
    cp $HOME/.bash_aliases $HOME/.bash_aliases.bak
    > $HOME/.bash_aliases
fi

echo "alias xclip='xclip -selection c'" >> $HOME/.bash_aliases
echo "alias tmux='tmux -2'" >> $HOME/.bash_aliases
echo "alias subl='xrun subl'" >> $HOME/.bash_aliases
echo "alias smerge='xrun smerge'" >> $HOME/.bash_aliases
echo "alias push='git push -u origin master'" >> $HOME/.bash_aliases
echo "alias tm='tmux attach -d'" >> $HOME/.bash_aliases

# SETTINGS/anacrontab
sudo -E bash -c 'echo -e "20\t0\tcron.monthly\t/bin/bash\t$SCRIPTS_FOLDER/monthly.sh" >> /etc/anacrontab'

# SETTINGS/Ramdisk
sudo mkdir $RAMDISK_MOUNT_POINT

# SETTINGS/Folders and Links

# ~/bin/
mkdir $HOME/bin/
if [ $BINARY_LINKS == "y" ]; then
    # Scripts
    ln -s "$SCRIPTS_FOLDER/currency-converter/eur.sh" $HOME/bin/eur
    ln -s "$SCRIPTS_FOLDER/currency-converter/usd.sh" $HOME/bin/usd
    ln -s "$SCRIPTS_FOLDER/currency-converter/gbp.sh" $HOME/bin/gbp
    ln -s "$SCRIPTS_FOLDER/currency-converter/ron.sh" $HOME/bin/ron
    ln -s "$SCRIPTS_FOLDER/rickrollrc-master/roll.sh" $HOME/bin/roll
    ln -s "$SCRIPTS_FOLDER/weather.sh" $HOME/bin/weather
    ln -s "$SCRIPTS_FOLDER/sw.sh" $HOME/bin/sw
    ln -s "$SCRIPTS_FOLDER/to.sh" $HOME/bin/to
    ln -s "$SCRIPTS_FOLDER/empty-trash.sh" $HOME/bin/empty-trash
    ln -s "$SCRIPTS_FOLDER/dark.sh" $HOME/bin/dark
    ln -s "$SCRIPTS_FOLDER/compile.sh" $HOME/bin/compile
    ln -s "$SCRIPTS_FOLDER/clean-usb.sh" $HOME/bin/clean-usb
    ln -s "$SCRIPTS_FOLDER/clean-usb-fat32.sh" $HOME/bin/clean-usb-fat32
    ln -s "$SCRIPTS_FOLDER/lookup.sh" $HOME/bin/lookup
    ln -s "$SCRIPTS_FOLDER/lookup.sh" $HOME/bin/lk
    ln -s "$SCRIPTS_FOLDER/bookmark.sh" $HOME/bin/bookmark
    ln -s "$SCRIPTS_FOLDER/bookmark.sh" $HOME/bin/bk
    ln -s "$SCRIPTS_FOLDER/timer.sh" $HOME/bin/timer
    ln -s "$SCRIPTS_FOLDER/xopen.sh" $HOME/bin/xopen
    ln -s "$SCRIPTS_FOLDER/xrun.sh" $HOME/bin/xrun
    ln -s "$SCRIPTS_FOLDER/srun.sh" $HOME/bin/srun
    ln -s "$SCRIPTS_FOLDER/websearch.py" $HOME/bin/websearch
    ln -s "$SCRIPTS_FOLDER/websearch.py" $HOME/bin/search
    ln -s "$SCRIPTS_FOLDER/websearch.py" $HOME/bin/s
    ln -s "$SCRIPTS_FOLDER/wordwrap-paste.sh" $HOME/bin/wp
    ln -s "$SCRIPTS_FOLDER/sound.sh" $HOME/bin/sound
    ln -s "$SCRIPTS_FOLDER/streams/twitch.sh" $HOME/bin/twitch
    ln -s "$SCRIPTS_FOLDER/streams/wtwitch.sh" $HOME/bin/wtwitch
    ln -s "$SCRIPTS_FOLDER/streams/sc2streams.sh" $HOME/bin/sc2streams
    ln -s "$SCRIPTS_FOLDER/search-replace.sh" $HOME/bin/search-replace
    ln -s "$SCRIPTS_FOLDER/goto.sh" $HOME/bin/goto
    ln -s "$SCRIPTS_FOLDER/work-done.sh" $HOME/bin/work-done
    ln -s "$SCRIPTS_FOLDER/ramdisk.sh" $HOME/bin/ramdisk
    ln -s "$SCRIPTS_FOLDER/edit-server-env.sh" $HOME/bin/edit-server-env
    ln -s "$SCRIPTS_FOLDER/tolower.py" $HOME/bin/tolower
    ln -s "$SCRIPTS_FOLDER/toupper.py" $HOME/bin/toupper
    ln -s "$SCRIPTS_FOLDER/insert-address.sh" $HOME/bin/insert-address
    # Cmus
    ln -s "$SCRIPTS_FOLDER/cmus-lyrics-master/cmus-lyrics" $HOME/bin/cmus-lyrics
    ln -s "$SCRIPTS_FOLDER/cmus-lyrics-master/cmus-lyrics" $HOME/bin/lyrics
    ln -s "$SCRIPTS_FOLDER/cmus-local/play-pause.sh" $HOME/bin/play-pause
    ln -s "$SCRIPTS_FOLDER/cmus-local/play-pause.sh" $HOME/bin/pp
    ln -s "$SCRIPTS_FOLDER/cmus-local/next.sh" $HOME/bin/next
    ln -s "$SCRIPTS_FOLDER/cmus-local/prev.sh" $HOME/bin/prev
    ln -s "$SCRIPTS_FOLDER/cmus-local/vol.sh" $HOME/bin/vol
    ln -s "$SCRIPTS_FOLDER/cmus-local/shuffle.sh" $HOME/bin/shuffle
    ln -s "$SCRIPTS_FOLDER/cmus-local/seek.sh" $HOME/bin/seek
    ln -s "$SCRIPTS_FOLDER/cmus-local/playlist.sh" $HOME/bin/playlist     
    ln -s "$SCRIPTS_FOLDER/cmus-local/playlists.sh" $HOME/bin/playlists     
    ln -s "$SCRIPTS_FOLDER/cmus-local/song.sh" $HOME/bin/song            
    
    # Binaries
    ln -s "$BINARIES_FOLDER/milestokm" $HOME/bin/milestokm
    ln -s "$BINARIES_FOLDER/kmtomiles" $HOME/bin/kmtomiles
    ln -s "$BINARIES_FOLDER/ftin" $HOME/bin/ftin
    ln -s "$BINARIES_FOLDER/cm" $HOME/bin/cm
    ln -s "$BINARIES_FOLDER/stats" $HOME/bin/stats
    ln -s "$BINARIES_FOLDER/word-frequency" $HOME/bin/word-frequency
    ln -s "$BINARIES_FOLDER/aec" $HOME/bin/aec
    ln -s "$BINARIES_FOLDER/rthreads.py" $HOME/bin/rthreads
fi

# ~/Desktop/
if [ $FOLDER_LINKS == "y" ]; then
    ln -s $HOME/Dropbox/Documents/ $HOME/Desktop/Documents
    ln -s $HOME/Dropbox/Documents/Carti/ $HOME/Desktop/Carti
    ln -s $HOME/Music/  $HOME/Desktop/Music
    ln -s $HOME/Downloads/  $HOME/Desktop/Downloads
    ln -s "$CODE_FOLDER" $HOME/Desktop/Code
    ln -s "$SCRIPTS_FOLDER" $HOME/Desktop/Bash-Scripts
    ln -s "$SCRIPTS_FOLDER" $HOME/Bash-Scripts
fi

# SETTINGS/Autostart

# Terminal
which $DEFAULT_TERMINAL_EMULATOR > /dev/null || export DEFAULT_TERMINAL_EMULATOR=gnome-terminal
mkdir -p $HOME/.config/autostart
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

# SETTINGS/Cosmetics

# Audacious Winamp skin
sudo cp "$(find $HOME -name *winamp_classic.wsz 2> /dev/null | head -1)" /usr/share/audacious/Skins/

# mc skin
mkdir -p $HOME/.local/share/mc/skins/
cp "$(find $HOME -name darkcourses_green.ini 2> /dev/null | head -1)" $HOME/.local/share/mc/skins/
gnome-terminal -e mc
echo "Please exit the mc instance that opened, using File->Exit."
read -N 1000000 -t 0.001 # Clear input
echo "Press ENTER to confirm."
read CONFIRMATION
sed -i 's/skin=default/skin=darkcourses_green/' $HOME/.config/mc/ini 

# SETTINGS/Wine Tweaks
sudo sed -i 's/#DefaultLimitNOFILE=.*/DefaultLimitNOFILE=1048576/' /etc/systemd/system.conf 
sudo sed -i 's/#DefaultLimitNOFILE=.*/DefaultLimitNOFILE=1048576/' /etc/systemd/user.conf 

# SETTINGS/ssh for GitHub
read -N 1000000 -t 0.001 # Clear input 
echo -n "Generate ssh key pair for GitHub? (Y/n): "  
read SSH_GITHUB
if [ "$SSH_GITHUB" == "y" ] || [ "$SSH_GITHUB" == "Y" ] || [ "$SSH_GITHUB" == "" ]; then
    ssh-keygen -t rsa -b 4096 
fi

# SETTINGS/ssh for phone
read -N 1000000 -t 0.001 # Clear input 
echo -n "Generate ssh key pair for connecting to phone? (Y/n): "
read SSH_PHONE
if [ "$SSH_PHONE" == "y" ] || [ "$SSH_PHONE" == "Y" ] || [ "$SSH_PHONE" == "" ]; then
    ssh-keygen -t rsa -b 4096 -f $HOME/.ssh/id_rsa_phone
fi
# SETTINGS/ssh for phone/copy id to phone
if [ -f $HOME/.ssh/id_rsa_phone ]; then
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
	    ssh-copy-id -p 8022 -i $HOME/.ssh/id_rsa_phone $PHONE_IP
	    echo "alias phone='ssh -p 8022 $PHONE_IP'" >> $HOME/.bash_aliases
	else
	    echo "alias phone='ssh -p 8022 $DEFAULT_PHONE_IP'" >> $HOME/.bash_aliases
	fi
fi

# SETTINGS/hostname
sudo -E bash -c "echo $HOSTNAME > /etc/hostname"

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
