#!/bin/bash

# Activate parallel downloads
echo -e "Activating pacman parallel downloads...\n"
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/g' /etc/pacman.conf

# Paru installation
echo -e "[+] Installing paru...\n"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..
rm -rf paru

#Installation
echo -e "[+] Installing some software with paru...\n"
paru -S python python-pip python-setuptools wget firefox kitty dunst zsh picom light alsa-utils blueberry feh lsd bat rofi libnotify thunar gvfs thunar-archive-plugin thunar-media-tags-plugin thunar-volman tumbler libgsf gvfs-mtp ttf-fira-code ttf-sourcecodepro-nerd polybar unzip lightdm-slick-greeter --noconfirm

# i3 config
echo -e "[+] Copying i3 and kitty config...\n"
cp -r i3 ~/.config/

# Kitty config
cp -r kitty ~/.config/

# ZSH config
echo -e "[+] Installing oh-my-zsh and its plugins...\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 

git clone --depth=1 https://github.com/romkatv/powerlevel10k ~/.oh-my-zsh/custom/themes/powerlevel10k 
cp zsh/.p10k.zsh ~/.p10k.zsh 

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 

cp zsh/.zshrc ~/.zshrc

echo -e "[+] Copying lightdm, polybar, rofi, picom, dunst, feh and zsh config...\n"
# LightDM config
sudo cp lightdm/lightdm.conf /etc/lightdm/
sudo cp lightdm/slick-greeter.conf /etc/lightdm/

mkdir -p /usr/share/backgrounds
cp feh/nebula.jpg /usr/share/backgrounds/

# Polybar config
cp -r polybar ~/.config/ 

# Rofi config
cp -r rofi ~/.config/ 

# Picom config
cp -r picom ~/.config/ 

# Dunst config
cp -r dunst ~/.config/ 

# Feh config
cp -r feh ~/.config/ 

echo -e "[+] Changing default shell to zsh...\n"
chsh -s /usr/bin/zsh

echo -e "[+] Installing lxappearance and some themes...\n"
paru -S breeze-icons lxappearance-gtk3 breeze-gtk arc-darkest-theme-git papirus-icon-theme --noconfirm

echo -e "[+] Installing Vimix GRUB theme...\n"
unzip vimix-theme.zip
sudo mv grub2-theme-vimix-master/Vimix /boot/grub/themes 2>/dev/null
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo -e "Copying the timer to automate the system update...\n"

cp timers/sysupdate.* /etc/systemd/system/
cp timers/system-update.sh /usr/local/bin/
chmod +x /usr/local/bin/system-update.sh

sudo systemctl enable --now sysupdate.timer
sudo systemctl start sysupdate.timer

echo -e "[+] Installing Snapd and VSCode...\n"
paru -S snapd --noconfirm

sudo systemctl enable --now snapd.socket
sudo systemctl start snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo systemctl enable --now snapd.apparmor

sudo snap install code --classic

echo "Now it is recommended that you reboot your system"
exit 0
