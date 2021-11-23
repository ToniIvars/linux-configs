# linux-configs
This repository is created to publish configuration files of some software in linux.

### Configs "installation"

The installation of the configs is very simple. You must run:
```
git clone https://github.com/ToniIvars/linux-configs.git
cd linux-configs
cp -r alacritty ~/.config/alacritty

cp -r qtile ~/.config/qtile
cd ~/.config/qtile
unzip wallpapers.zip
unzip layout-icons.zip

rm layout-icons.zip wallpapers.zip
```
### Alacritty installation
To install Alacritty, you can refer to [Alacritty Installation](https://github.com/alacritty/alacritty/blob/master/INSTALL.md) or run `sudo snap install alacritty --classic`.

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
