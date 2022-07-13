#!/bin/bash

# Paru installation
echo -e "[+] Installing paru...\n"
cd Documents
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru

#Installation
echo -e "[+] Installing some software with paru...\n"
paru -S python python-pip python-setuptools wget firefox kitty dunst zsh picom light alsa-utils blueberry feh lsd bat rofi libnotify thunar gvfs thunar-archive-plugin thunar-media-tags-plugin thunar-volman tumbler libgsf gvfs-mtp ttf-fira-code nerd-fonts-source-code-pro polybar snapd --noconfirm

sudo systemctl enable --now snapd.socket
sudo systemctl start snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

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

echo -e "[+] Copying polybar, rofi, picom, dunst, feh and zsh config...\n"
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

echo -e "[+] Installing VS Code with snap...\n"
sudo snap install code --classic

echo -e "[+] Installing lxappearance and some themes"
paru -S bibata-cursor-theme-bin breeze-icons lxappearance-gtk3 breeze-gtk arc-gtk-theme arc-icon-theme arc-darkest-theme-git papirus-icon-theme --noconfirm