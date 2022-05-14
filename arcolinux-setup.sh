#Installation
sudo pacman -S wget firefox kitty dunst zsh picom light alsa-utils blueberry feh lsd bat rofi libnotify thunar gvfs thunar-archive-plugin thunar-media-tags-plugin thunar-volman tumbler libgsf gvfs-mtp ttf-fira-code --noconfirm
paru -S nerd-fonts-source-code-pro polybar snapd --noconfirm
sudo snap install code --classic

# i3 config
cp -r i3 ~/.config/

# Kitty config
cp -r kitty ~/.config/

# ZSH config
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone --depth=1 https://github.com/romkatv/powerlevel10k ~/.oh-my-zsh/custom/themes/powerlevel10k
cp zsh/.p10k.zsh ~/.p10k.zsh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

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

chsh -s /usr/bin/zsh
