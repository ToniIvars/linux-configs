#Installation
sudo pacman -S kitty dunst zsh picom light alsa-utils blueberry feh lsd bat rofi libnotify --noconfirm
paru -S nerd-fonts-source-code-pro polybar --noconfirm

# Clone the repo
git clone https://github.com/ToniIvars/linux-configs.git
cd linux-configs

# i3 config
cp -r i3 ~/.config/

# Kitty config
cp -r kitty ~/.config/

# ZSH config
cp zsh/.zshrc ~/.zshrc

sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k ~/.oh-my-zsh/custom/themes/powerlevel10k
cp zsh/.p10k.zsh ~/.p10k.zsh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

chsh -s /usr/bin/zsh

# Polybar config
cp -r polybar ~/.config/

# Rofi config
cp -r rofi ~/.config/

# Picom config
cp -r picom ~/.config/

# Dunst config
cp -r dunst ~/.config/
