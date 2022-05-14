#!/bin/bash

#Installation
echo -e "[+] Installing some software with paru...\n"
paru -S wget firefox kitty dunst zsh picom light alsa-utils blueberry feh lsd bat rofi libnotify thunar gvfs thunar-archive-plugin thunar-media-tags-plugin thunar-volman tumbler libgsf gvfs-mtp ttf-fira-code nerd-fonts-source-code-pro polybar snapd --noconfirm

echo -e "[+] Installing VS Code with snap...\n"
sudo snap install code --classic

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

echo -e "[+] Copying polybar, rofi, picom, dunst, feh and zsh config...\n"
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

cp zsh/.zshrc ~/.zshrc

echo -e "[+] Changing default shell to zsh...\n"
chsh -s /usr/bin/zsh
