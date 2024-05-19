# i3 config
cp -r ~/.config/i3 .

# Kitty config
cp -r ~/.config/kitty .

# ZSH config
cp ~/.p10k.zsh zsh/
cp ~/.zshrc zsh/

# LightDM config
sudo cp /etc/lightdm/lightdm.conf lightdm/
sudo cp /etc/lightdm/slick-greeter.conf lightdm/

# Polybar config
cp -r ~/.config/polybar .

# Rofi config
cp -r ~/.config/rofi .

# Picom config
cp -r ~/.config/picom .

# Dunst config
cp -r ~/.config/dunst .

# Feh config
cp -r ~/.config/feh .