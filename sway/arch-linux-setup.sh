#!/bin/bash

# Activate parallel downloads
echo -e "Activating pacman parallel downloads...\n"
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/g' /etc/pacman.conf

# yay installation
echo -e "[+] Installing yay...\n"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

#Installation
echo -e "[+] Installing some software with yay...\n"
yay -S sway swaybg swaylock swayidle rofi waybar wl-clipboard xdg-desktop-portal-wlr brightnessctl mako grim slurp grimshot qtgreet python python-pip python-setuptools wget firefox kitty zsh acpi alsa-utils bluez bluez-utils blueberry lsd bat libnotify thunar gvfs thunar-archive-plugin thunar-media-tags-plugin thunar-volman tumbler libgsf gvfs-mtp ttf-fira-code ttf-sourcecodepro-nerd noto-fonts unzip downgrade docker docker-compose pacman-contrib leafpad ark visual-studio-code-bin walk tailscale starship --noconfirm

# Sway config
echo -e "[+] Copying Sway and Kitty config...\n"
cp -r sway ~/.config/

# Kitty config
cp -r kitty ~/.config/

# ZSH config
echo -e "[+] Installing oh-my-zsh and its plugins...\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 


git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 

echo -e "[+] Copying lightdm, polybar, rofi, dunst and zsh config...\n"
cp -r starship ~/.config/
cp zsh/.zshrc ~/.zshrc

# LightDM config
sudo cp lightdm/lightdm.conf /etc/lightdm/
sudo cp lightdm/slick-greeter.conf /etc/lightdm/

sudo mkdir -p /usr/share/backgrounds
sudo cp sway/nebula.jpg /usr/share/backgrounds/

# Polybar config
cp -r polybar ~/.config/ 

# Rofi config
cp -r rofi ~/.config/ 

# Dunst config
cp -r dunst ~/.config/ 

echo -e "[+] Changing default shell to zsh and adding user to video group...\n"
chsh -s /usr/bin/zsh
sudo usermod -aG video $(whoami)

echo -e "[+] Installing UI configurations...\n"
yay -S lxappearance qt5ct kvantum kvantum-theme-arc arc-gtk-theme papirus-icon-theme xcursor-breeze --noconfirm

echo -e "[+] Copying the timer to automate the system update...\n"
sudo cp timers/sysupdate.* /etc/systemd/system/
sudo cp timers/system-update.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/system-update.sh
sudo systemctl enable --now sysupdate.timer

echo -e "[+] Enabling bluetooth and tailscale services...\n"
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now tailscaled

echo -e "[+] Copying custom utilities to /usr/local/bin...\n"
sudo cp utilities/* /usr/local/bin
for filename in utilities/*; do
    sudo chmod +x /usr/local/bin/$(basename $filename)
done

echo -e "[+] Copying custom application handlers to /usr/share/applications...\n"
sudo cp application-handlers/* /usr/share/applications/

echo -e  "\n[+] Now it is recommended that you reboot your system"
echo "[+] After doing it, start lxappearance, kvantum-manager and qtct to configure the UI"
exit 0
