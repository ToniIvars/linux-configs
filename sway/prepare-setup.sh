# Sway config
cp -r ~/.config/sway .
cp -r ~/.config/swaylock .

# Kitty config
cp -r ~/.config/kitty .

# ZSH config
cp ~/.zshrc zsh/

# LightDM config
sudo cp /etc/lightdm/lightdm.conf lightdm/
sudo cp /etc/lightdm/slick-greeter.conf lightdm/

# Waybar config
cp -r ~/.config/waybar .

# Rofi config
cp -r ~/.config/rofi .

# Mako config
cp -r ~/.config/mako .

# Starship config
cp -r ~/.config/starship .

# Utilities
sudo find /usr/local/bin -maxdepth 1 -type f | xargs -I {} cp {} utilities/

# Custom application handlers
cp /usr/share/applications/acestream-url-handler.desktop application-handlers/

# Run tailscale without the password
sudo cp /etc/sudoers.d/tailscale tailscale/
sudo chown $USER:$USER tailscale/tailscale && chmod 755 tailscale/tailscale
