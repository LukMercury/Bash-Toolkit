#!/bin/bash

# Linux post install setup file
# Created by Mihai Luca <mihailuca406@gmail.com>
# Distribution currently used: Feren OS based on Ubuntu/Mint

# ------------------------------------------------------------------------------------------------------------------------------

# VARIABLES

# SMTP Server variable is configured in the SETTINGS/Email section
MAIN_EMAIL=mihailuca406@gmail.com
GIT_EMAIL=$MAIN_EMAIL
FIRSTNAME=Mihai
LASTNAME=Luca
RUN_FOLDER=$HOME/Desktop
SCRIPTS_FOLDER=$HOME/Dropbox/Bash-Scripts
BINARIES_FOLDER=$HOME/Dropbox/bin
CODE_FOLDER=$HOME/Dropbox/Code
RAMDISK_MOUNT_POINT=/mnt/ramdisk
UBUNTU_CODENAME="$(lsb_release -a 2> /dev/null | grep Codename | tr -d [:space:] | cut -d: -f2)"
export DEFAULT_TERMINAL_EMULATOR=/usr/bin/terminology
export CURRENT_USER=$USER

# ONLINE SOURCES

ZSH_SETUP=https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
VIRTUALBOX=https://download.virtualbox.org/virtualbox/6.0.10/virtualbox-6.0_6.0.10-132072~Ubuntu~bionic_amd64.deb
VBOX_EXTENSION_PACK=https://download.virtualbox.org/virtualbox/6.0.8/Oracle_VM_VirtualBox_Extension_Pack-6.0.8.vbox-extpack
TEAMSPEAK=http://dl.4players.de/ts/releases/3.2.2/TeamSpeak3-Client-linux_amd64-3.2.2.run
DISCORD=https://discordapp.com/api/download?platform=linux&format=deb
TEAMVIEWER=https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
ATOM=https://atom.io/download/deb
DMD=http://downloads.dlang.org/releases/2.x/2.087.0/dmd_2.087.0-0_amd64.deb
TOR_BROWSER=https://www.torproject.org/dist/torbrowser/8.5.4/tor-browser-linux64-8.5.4_en-US.tar.xz

# ------------------------------------------------------------------------------------------------------------------------------


# PRELIMINARY SETTINGS & CHECKS

if [ ! -d "$RUN_FOLDER" ]; then
    mkdir -p "$RUN_FOLDER"
fi
cd "$RUN_FOLDER" # additional files will be created in this folder
exec 2> install-log.txt # send error stream to log file

# REPOSITORIES

# REPOSITORIES/Sublime Text
wget -qO- https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo bash -c 'echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublime-text.list'

# REPOSITORIES/Wine
wget -nc https://dl.winehq.org/wine-builds/Release.key -O- | sudo apt-key add -
sudo apt-add-repository -y "deb https://dl.winehq.org/wine-builds/ubuntu/ $UBUNTU_CODENAME main"

# REPOSITORIES/Lutris
sudo add-apt-repository -y ppa:lutris-team/lutris

# REPOSITORIES/webupd8
sudo add-apt-repository -y ppa:nilarimogard/webupd8

# REPOSITORIES/Typora
wget -qO- https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository -y 'deb https://typora.io/linux ./'


# INSTALL

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
sudo apt install -y errno
sudo apt install -y pstree
sudo apt install -y finger
sudo apt install -y xclip
sudo apt install -y openssh-server
sudo apt install -y sshfs
sudo apt install -y nnn
sudo apt install -y w3m
sudo apt install -y postfix
sudo apt install -y mailutils
sudo apt install -y clamav
sudo apt install -y gparted
sudo apt install -y woeusb
sudo apt install -y psensor
sudo apt install -y gkrellm
sudo apt install -y g++
sudo apt install -y ldc
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
sudo apt install -y octave
sudo apt install -y liboctave-dev
sudo apt install -y ddd
sudo apt install -y ddd-doc
sudo apt install -y valgrind
sudo apt install -y valgrind-dbg
sudo apt install -y dia
sudo apt install -y ttf-mscorefonts-installer
sudo apt install -y fonts-inconstolata
sudo apt install -y pandoc
sudo apt install -y texlive
sudo apt install -y img2pdf
sudo apt install -y fbreader
sudo apt install -y typora
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
sudo apt install -y nvidia-driver-430 
sudo apt install -y libnvidia-gl-430
sudo apt install -y libnvidia-gl-430:i386
sudo apt install -y libvulkan1 
sudo apt install -y libvulkan1:i386
sudo apt install -y winehq-stable
sudo apt install -y playonlinux
sudo apt install -y lutris
sudo apt install -y steam
sudo apt install -y flatpak
sudo apt install -y gnome-software-plugin-flatpak

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
wget -O virtualbox.deb $VIRTUALBOX 2> /dev/null # get rid of excessive output
sudo dpkg -i virtualbox.deb
rm -f virtualbox.deb
wget $VBOX_EXTENSION_PACK 2> /dev/null  # get rid of excessive output
echo "Virtualbox Extension Pack downloaded, install manually." 1>&2

# INSTALL/Download/TeamSpeak
wget -O teamspeak.run $TEAMSPEAK 2> /dev/null   # get rid of excessive output
chmod +x teamspeak.run
./teamspeak.run
rm -f teamspeak.run
sudo mv TeamSpeak* /opt/
echo "TeamSpeak: create a lanucher pointing to /opt/TeamSpeak3-Client-linux_amd64/ts3client_runscript.sh" 1>&2

# INSTALL/Download/Discord
wget -O discord.deb $DISCORD 2> /dev/null   # get rid of excessive output
sudo dpkg -i discord.deb
rm -f discord.deb
sudo apt install -f -y

# INSTALL/TeamViewer
wget -O teamviewer.deb $TEAMVIEWER 2> /dev/null # get rid of excessive output
sudo dpkg -i teamviewer.deb
rm -f teamviewer.deb
sudo apt install -f -y

# INSTALL/Download/Atom
wget -O atom.deb $ATOM 2> /dev/null # get rid of excessive output
sudo dpkg -i atom.deb
rm -f atom.deb

# INSTALL/Download/DMD
wget -O dmd.deb $DMD 2> /dev/null    # get rid of excessive output 
sudo dpkg -i dmd.deb
rm -f dmd.deb

# INSTALL/Download/Tor Browser
wget -O tor-browser.tar.xz $TOR_BROWSER 2> /dev/null    # get rid of excessive output
tar -xvf tor-browser.tar.xz
sudo mv tor-browser_en-US /opt/
echo "Tor Browser installed in /opt. Create menu launcher manually." 1>&2
rm -f tor-browser.tar.xz


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
read -N 1000000 -t 0.01 # Clear input for email address read
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
chsh -s $(which zsh)
echo 'source $HOME/.bash_aliases' >> $HOME/.zshrc

# SETTINGS/Default Terminal Emulator
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
sudo -E bash -c 'echo "\" $CURRENT_USER" >> /etc/vim/vimrc.local'
sudo bash -c 'echo >> /etc/vim/vimrc.local'
sudo bash -c 'echo "\" set background=dark" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set number" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set is" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set cindent" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set expandtab" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set tabstop=4" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set shiftwidth=4" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set mouse=a" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set splitright" >> /etc/vim/vimrc.local'
# Plug
sudo bash -c 'echo >> /etc/vim/vimrc.local'
sudo bash -c 'echo "call plug#begin('\''~/.vim/plugged'\'')" >> /etc/vim/vimrc.local'
sudo bash -c 'echo >> /etc/vim/vimrc.local'
sudo bash -c 'echo "Plug '\''https://github.com/NLKNguyen/papercolor-theme'\''" >> /etc/vim/vimrc.local'
sudo bash -c 'echo >> /etc/vim/vimrc.local'
sudo bash -c 'echo "call plug#end()" >> /etc/vim/vimrc.local'
sudo bash -c 'echo >> /etc/vim/vimrc.local'
# Color Theme
sudo bash -c 'echo "set t_Co=256" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "set background=dark" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "colorscheme PaperColor" >> /etc/vim/vimrc.local'
# Keyboard Shortcuts remap
sudo bash -c 'echo >> /etc/vim/vimrc.local'
sudo bash -c 'echo "tnoremap <Esc><Esc> <C-\><C-n>" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "tnoremap <C-h> <C-\><C-n><C-w>h" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "tnoremap <C-j> <C-\><C-n><C-w>j" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "tnoremap <C-k> <C-\><C-n><C-w>k" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "tnoremap <C-l> <C-\><C-n><C-w>l" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "nnoremap <C-h> <C-w>h" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "nnoremap <C-j> <C-w>j" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "nnoremap <C-k> <C-w>k" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "nnoremap <C-l> <C-w>l" >> /etc/vim/vimrc.local'

# SETTINGS/nvim
mkdir $HOME/.config/nvim
cat /etc/vim/vimrc.local > $HOME/.config/nvim/init.vim
sed -i 's/\~\/\.vim\/plugged/\~\.local\/share\/nvim\/plugged/' $HOME/.config/nvim/init.vim 
echo "vnoremap <C-c> \"+y" >> $HOME/.config/nvim/init.vim
echo "nnoremap <C-v> o<Esc>\"+p0" >> $HOME/.config/nvim/init.vim
sed -i '5 i set nohlsearch' $HOME/.config/nvim/init.vim
sed -i '13 i set nomodeline' $HOME/.config/nvim/init.vim

# SETTINGS/vimrc 2 (different from nvim/init.vim)
sudo bash -c 'echo "vnoremap <C-c> :w !xclip -sel c<CR><CR>" >> /etc/vim/vimrc.local'
sudo bash -c 'echo "vnoremap <C-v> :r !xclip -sel c -o<CR>" >> /etc/vim/vimrc.local'

# SETTINGS/vim/PlugInstall
vim -c PlugInstall -c qa

# SETTINGS/nvim/PlugInstall
nvim -c PlugInstall -c qa

# SETTINGS/Aliases
if [ -f $HOME/.bash_aliases ]; then
    cp $HOME/.bash_aliases $HOME/.bash_aliases.bak
    > $HOME/.bash_aliases
fi

echo "alias xclip='xclip -selection c'" >> $HOME/.bash_aliases
echo "alias tmux='tmux -2'" >> $HOME/.bash_aliases
echo "alias subl='xrun subl'" >> $HOME/.bash_aliases
echo "alias smerge='xrun smerge'" >> $HOME/.bash_aliases

# SETTINGS/Ramdisk
sudo mkdir $RAMDISK_MOUNT_POINT

# SETTINGS/Folders and Links

# ~/bin/
mkdir $HOME/bin/
# Scripts
ln -s "$SCRIPTS_FOLDER/currency-converter/eur.sh" $HOME/bin/eur
ln -s "$SCRIPTS_FOLDER/currency-converter/usd.sh" $HOME/bin/usd
ln -s "$SCRIPTS_FOLDER/currency-converter/gbp.sh" $HOME/bin/gbp
ln -s "$SCRIPTS_FOLDER/currency-converter/ron.sh" $HOME/bin/ron
ln -s "$SCRIPTS_FOLDER/rickrollrc-master/roll.sh" $HOME/bin/roll
ln -s "$SCRIPTS_FOLDER/weather.sh" $HOME/bin/weather
ln -s "$SCRIPTS_FOLDER/get-dir.sh" $HOME/bin/get-dir
ln -s "$SCRIPTS_FOLDER/sw.sh" $HOME/bin/sw
ln -s "$SCRIPTS_FOLDER/to.sh" $HOME/bin/to
ln -s "$SCRIPTS_FOLDER/empty-trash.sh" $HOME/bin/empty-trash
ln -s "$SCRIPTS_FOLDER/dark.sh" $HOME/bin/dark
ln -s "$SCRIPTS_FOLDER/compile.sh" $HOME/bin/compile
ln -s "$SCRIPTS_FOLDER/clean-usb.sh" $HOME/bin/clean-usb
ln -s "$SCRIPTS_FOLDER/lookup.sh" $HOME/bin/lookup
ln -s "$SCRIPTS_FOLDER/lookup.sh" $HOME/bin/lk
ln -s "$SCRIPTS_FOLDER/bookmark.sh" $HOME/bin/bookmark
ln -s "$SCRIPTS_FOLDER/bookmark.sh" $HOME/bin/bk
ln -s "$SCRIPTS_FOLDER/end-session.sh" $HOME/bin/end-session
ln -s "$SCRIPTS_FOLDER/safe-reboot.sh" $HOME/bin/safe-reboot
ln -s "$SCRIPTS_FOLDER/timer.sh" $HOME/bin/timer
ln -s "$SCRIPTS_FOLDER/xopen.sh" $HOME/bin/xopen
ln -s "$SCRIPTS_FOLDER/xrun.sh" $HOME/bin/xrun
ln -s "$SCRIPTS_FOLDER/wordwrap-paste.sh" $HOME/bin/wp
ln -s "$SCRIPTS_FOLDER/sound.sh" $HOME/bin/sound
ln -s "$SCRIPTS_FOLDER/streams/twitch.sh" $HOME/bin/twitch
ln -s "$SCRIPTS_FOLDER/streams/wtwitch.sh" $HOME/bin/wtwitch
ln -s "$SCRIPTS_FOLDER/streams/sc2streams.sh" $HOME/bin/sc2streams
ln -s "$SCRIPTS_FOLDER/search-replace.sh" $HOME/bin/search-replace
ln -s "$SCRIPTS_FOLDER/goto.sh" $HOME/bin/goto
ln -s "$SCRIPTS_FOLDER/work-done.sh" $HOME/bin/work-done
ln -s "$SCRIPTS_FOLDER/ramdisk.sh" $HOME/bin/ramdisk
# Cmus
ln -s "$SCRIPTS_FOLDER/cmus-lyrics-master/cmus-lyrics" $HOME/bin/cmus-lyrics
ln -s "$SCRIPTS_FOLDER/cmus-local/cmus-save.sh" $HOME/bin/cmus-save     
ln -s "$SCRIPTS_FOLDER/cmus-local/cmus-load.sh" $HOME/bin/cmus-load    
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

# ~/Desktop/
ln -s $HOME/Dropbox/Documents/ $HOME/Desktop/Documents
ln -s $HOME/Dropbox/Documents/Carti/ $HOME/Desktop/Carti
ln -s $HOME/Music/  $HOME/Desktop/Music
ln -s $HOME/Downloads/  $HOME/Desktop/Downloads
ln -s "$CODE_FOLDER" $HOME/Desktop/Code
ln -s "$SCRIPTS_FOLDER" $HOME/Desktop/Bash-Scripts

# SETTINGS/Autostart

# Terminal
which $DEFAULT_TERMINAL_EMULATOR > /dev/null || export DEFAULT_TERMINAL_EMULATOR=gnome-terminal
> /home/$USER/.config/autostart/Terminal.desktop
bash -c 'echo "[Desktop Entry]" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "Type=Application" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "Exec=$DEFAULT_TERMINAL_EMULATOR -F -e tmux -2" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "X-GNOME-Autostart-enabled=true" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "NoDisplay=false" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "Hidden=false" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "Name[en_US]=Terminal" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "Comment[en_US]=No description" >> /home/$USER/.config/autostart/Terminal.desktop'
bash -c 'echo "X-GNOME-Autostart-Delay=0" >> /home/$USER/.config/autostart/Terminal.desktop'

# SETTINGS/Cosmetics

# Audacious Winamp skin
sudo cp "$(find $HOME -name *winamp_classic.wsz 2> /dev/null | head -1)" /usr/share/audacious/Skins/

# mc skin
mkdir -p $HOME/.local/share/mc/skins/
cp "$(find $HOME -name darkcourses_green.ini 2> /dev/null | head -1)" $HOME/.local/share/mc/skins/
gnome-terminal -e mc
echo "Please exit the mc instance that opened, using File->Exit."
read -N 1000000 -t 0.01 # Clear input for mc exit confirmation
echo "Press ENTER to confirm."
read CONFIRMATION
sed -i 's/skin=default/skin=darkcourses_green.ini' $HOME/.config/mc/ini 

# Cmus Taskbar Controls
unzip "$(find $HOME -name cmus-taskbar-controls.zip 2> /dev/null | head -1)" -d $HOME/.cinnamon/configs/

# SETTINGS/Wine Tweaks
sudo sed -i 's/#DefaultLimitNOFILE=/DefaultLimitNOFILE=1048576/' /etc/systemd/system.conf 
sudo sed -i 's/#DefaultLimitNOFILE=/DefaultLimitNOFILE=1048576/' /etc/systemd/user.conf 

# DONE
echo -e "\nDone!"
read -N 1000000 -t 0.01 # Clear input for reboot confirmation
echo -n "Restart your system now? (Y/n): "
read INPUT
if [ "$INPUT" == "n" ] || [ "$INPUT" == "N" ]; then
    exit 0
else
    sudo reboot
fi

