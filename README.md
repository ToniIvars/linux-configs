# linux-configs
This repository is created to publish configuration files of some software in linux.

## Zsh installation
Then, to install some of its dependencies, you can run the following commands: 
```
# Install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clone powerlevel10k theme for oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k ~/.oh-my-zsh/custom/themes/powerlevel10k
cp zsh/.p10k.zsh ~/.p10k.zsh

# Clone zsh-autosuggestions plugins for oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Clone zsh-syntax-highlighting plugins for oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

## Default software
- Web browser: Firefox
- Code editor: Visual Studio Code
- File manager: Thunar

### Notes
- A system update is performed using cron
- Some important extra packages could be [feh](https://feh.finalrewind.org/), [light](https://github.com/haikarainen/light#installation), [lsd](https://github.com/Peltoche/lsd) or [bat](https://github.com/sharkdp/bat)
- It is recommended to have some [Nerd Font](https://www.nerdfonts.com/font-downloads) installed ([SauceCodePro](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip) as default)
