# linux-configs
This repository is created to publish configuration files of some software in linux.

### Configs "installation"

The installation of the configs is very simple. You must run:
```
# Clone the repo
git clone https://github.com/ToniIvars/linux-configs.git
cd linux-configs

# Copy Alacritty config
cp -r alacritty ~/.config/

# Copy Kitty config
cp -r kitty ~/.config/

# Copy Picon config
cp -r picom ~/.config/

# Copy Dunst config
cp -r dunst ~/.config/

# Copy .zshrc
cp zsh/.zshrc ~/.zshrc

# Copy Qtile config
cp -r qtile ~/.config/
cd ~/.config/qtile
unzip wallpapers.zip
unzip layout-icons.zip
rm layout-icons.zip wallpapers.zip
```
### Alacritty installation
To install Alacritty, you can refer to [Alacritty Installation](https://github.com/alacritty/alacritty/blob/master/INSTALL.md) or run:
- `sudo snap install alacritty --classic` in Ubuntu.
- `sudo pacman -S alacritty` in Arch.

### Kitty installation
To install Kitty, you can refer to [Kitty Installation](https://sw.kovidgoyal.net/kitty/binary/) or run `sudo pacman -S kitty` in Arch.

### Qtile installation
You can run different commands to install Qtile in different distros.
- Ubuntu / Debian:
```
sudo apt install python3-cffi xserver-xorg python3-xcffib libpangocairo-1.0-0
pip install --no-cache-dir cairocffi
pip install qtile
```
- Arch: `sudo pacman -S qtile`

Once installed Qtile, you must create a **qtile.desktop** file in `/usr/share/xsessions`. To do that, you can run:
```
cd /usr/share/xsessions
sudo wget https://raw.githubusercontent.com/qtile/qtile/master/resources/qtile.desktop
```

### Picom installation
To install Picom, you can refer to [Picom Installation](https://github.com/yshui/picom#build).

### Dunst installation
To install Dunst, you can run `sudo apt install dunst` in Ubuntu or `sudo pacman -S dunst` in Arch.

### Zsh installation
To install Zsh, you can run `sudo apt install zsh` in Ubuntu or `sudo pacman -S zsh` in Arch.

Then, to install some of its dependencies, you can run the following commands: 
```
# Install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clone powerlevel10k theme for oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k ~/.oh-my-zsh/custom/themes/powerlevel10k
cp zsh/.p10k.zsh ~/.p10k.zsh

# Clone zsh-autosuggestions plugins for oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
```

### Default software
- Web browser: Firefox
- Code editor: Visual Studio Code
- File manager: Thunar

### Some dependencies
- [dmenu](https://github.com/ToniIvars/dmenu) (my own fork)
- [light](https://github.com/haikarainen/light#installation)
- amixer
- iwgetid
- bluetoothctl
- hcitool
- nmtui
- [feh](https://feh.finalrewind.org/)
- bluetooth_config (selfmade tool in this repository too, install in `/usr/bin/` and give execution privileges)
- Some [Nerd Font](https://www.nerdfonts.com/font-downloads) ([SauceCodePro](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip) as default)

### Notes
- A system update is performed using cron
