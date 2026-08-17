#!/bin/bash

MATLAB_DIR="$HOME/matlab-test"

confirm() {
    read -p "$1 [y/n]: " yn
    case $yn in
        [Yy]*|"" ) return 0;;
        * ) exit 1;;
    esac
}

if ls "$MATLAB_DIR" &>/dev/null; then
    confirm "Ya existe el directorio $MATLAB_DIR. ¿Quieres sobreescribirlo?" && rm -rf "$MATLAB_DIR"
fi

if ! pacman -Qq matlab-mpm &>/dev/null; then
    if confirm "matlab-mpm no está instalado en el sistema. ¿Quieres instalarlo?"; then
	echo "[+] Instalando matlab-mpm..."
	yay -S matlab-mpm --noconfirm 2>/dev/null
        echo
    fi
fi

read -p "¿Qué version de MATLAB quieres instalar? " MATLAB_VERSION

matlab-mpm install --release="$MATLAB_VERSION" --destination="$MATLAB_DIR" MATLAB Symbolic_Math_Toolbox || exit 1
echo

export MATLAB_DIR

sh -c '"$MATLAB_DIR/bin/glnxa64/MathWorksProductAuthorizer" 2>/dev/null'

if [ $? -eq 139 ]; then
    mkdir "$MATLAB_DIR/gnutls" 2>/dev/null && \
        echo "[+] Instalando gnutls personalizado..." && \
        wget https://archive.archlinux.org/packages/g/gnutls/gnutls-3.8.9-1-x86_64.pkg.tar.zst -O /tmp/gnutls-3.8.9-1-x86_64.pkg.tar.zst &>/dev/null && \
        bsdtar -xf /tmp/gnutls-3.8.9-1-x86_64.pkg.tar.zst -C "$MATLAB_DIR/gnutls" &>/dev/null && \
        rm /tmp/gnutls-3.8.9-1-x86_64.pkg.tar.zst &>/dev/null
fi

sh -c 'LD_LIBRARY_PATH="$MATLAB_DIR/gnutls/usr/lib:$LD_LIBRARY_PATH" "$MATLAB_DIR/bin/glnxa64/MathWorksProductAuthorizer" 2>/dev/null'

if [ $? -eq 134 ]; then
    mkdir "$MATLAB_DIR/nettle" 2>/dev/null && \
        echo "[+] Instalando nettle personalizado..." && \
        wget https://archive.archlinux.org/packages/n/nettle/nettle-3.10.2-1-x86_64.pkg.tar.zst -O /tmp/nettle-3.10.2-1-x86_64.pkg.tar.zst &>/dev/null && \
        bsdtar -xf /tmp/nettle-3.10.2-1-x86_64.pkg.tar.zst -C "$MATLAB_DIR/nettle" &>/dev/null && \
        rm /tmp/nettle-3.10.2-1-x86_64.pkg.tar.zst &>/dev/null
fi

LD_LIBRARY_PATH="$MATLAB_DIR/gnutls/usr/lib:$MATLAB_DIR/nettle/usr/lib:$LD_LIBRARY_PATH" "$MATLAB_DIR/bin/glnxa64/MathWorksProductAuthorizer"
