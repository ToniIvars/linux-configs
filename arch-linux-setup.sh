#!/bin/bash

# Activate parallel downloads
echo -e "Activating pacman parallel downloads...\n"
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/g' /etc/pacman.conf

# Paru installation
echo -e "[+] Installing paru...\n"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru

#Installation
echo -e "[+] Installing some software with paru...\n"
paru -S python python-pip python-setuptools wget firefox kitty dunst zsh picom light alsa-utils blueberry feh lsd bat rofi libnotify thunar gvfs thunar-archive-plugin thunar-media-tags-plugin thunar-volman tumbler libgsf gvfs-mtp ttf-fira-code ttf-sourcecodepro-nerd polybar unzip lightdm-slick-greeter --noconfirm

# i3 config
echo -e "[+] Copying i3 and kitty config...\n"
cp -r i3 ~/.config/ &>/dev/null

# Kitty config
cp -r kitty ~/.config/ &>/dev/null

# ZSH config
echo -e "[+] Installing oh-my-zsh and its plugins...\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &>/dev/null

git clone --depth=1 https://github.com/romkatv/powerlevel10k ~/.oh-my-zsh/custom/themes/powerlevel10k &>/dev/null
cp zsh/.p10k.zsh ~/.p10k.zsh &>/dev/null

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions &>/dev/null

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &>/dev/null

echo -e "[+] Copying lightdm, polybar, rofi, picom, dunst, feh and zsh config...\n"
# LightDM config
cp lightdm/lightdm.conf /etc/lightdm/
cp lightdm/slick-greeter.conf /etc/lightdm/
cp feh/nebula.jpg /usr/share/backgrounds/

# Polybar config
cp -r polybar ~/.config/ &>/dev/null

# Rofi config
cp -r rofi ~/.config/ &>/dev/null

# Picom config
cp -r picom ~/.config/ &>/dev/null

# Dunst config
cp -r dunst ~/.config/ &>/dev/null

# Feh config
cp -r feh ~/.config/ &>/dev/null

cp zsh/.zshrc ~/.zshrc &>/dev/null

echo -e "[+] Changing default shell to zsh...\n"
chsh -s /usr/bin/zsh

echo -e "[+] Installing lxappearance and some themes...\n"
paru -S breeze-icons lxappearance-gtk3 breeze-gtk arc-darkest-theme-git papirus-icon-theme --noconfirm

echo -e "[+] Installing Vimix GRUB theme...\n"
unzip vimix-theme.zip
sudo mv grub2-theme-vimix-master/Vimix /boot/grub/themes 2>/dev/null
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo -e "[+] Installing Snapd and VSCode...\n"
paru -S snapd --noconfirm

sudo systemctl enable --now snapd.socket
sudo systemctl start snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo systemctl enable --now snapd.apparmor

sudo snap install code --classic

echo -e "Copying the timer to automate the system update...\n"

cp timers/sysupdate.* /etc/systemd/system/
cp timers/system-update.sh /usr/local/bin/
chmod +x /usr/local/bin/system-update.sh

sudo systemctl enable --now sysupdate.timer
sudo systemctl start sysupdate.timer

echo "Now it is recommended that you reboot your system"
exit 0
