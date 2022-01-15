#!/usr/bin/env bash
#-------------------------------------------------------------------------
#   █████╗ ██████╗  ██████╗██╗  ██╗████████╗██╗████████╗██╗   ██╗███████╗
#  ██╔══██╗██╔══██╗██╔════╝██║  ██║╚══██╔══╝██║╚══██╔══╝██║   ██║██╔════╝
#  ███████║██████╔╝██║     ███████║   ██║   ██║   ██║   ██║   ██║███████╗
#  ██╔══██║██╔══██╗██║     ██╔══██║   ██║   ██║   ██║   ██║   ██║╚════██║
#  ██║  ██║██║  ██║╚██████╗██║  ██║   ██║   ██║   ██║   ╚██████╔╝███████║
#  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝   ╚═╝    ╚═════╝ ╚══════╝
#-------------------------------------------------------------------------

echo "
###############################################################################
# Configuring Best Mirrors & Setting up repos
###############################################################################
"

sudo pacman -S reflector --noconfirm
sudo reflector -a 48 -c SE -f 5 -l 20 --sort rate --save /etc/pacman.d/mirrorlist
sudo cp -f ~/L/mirrorlists/*-mirrorlist /etc/pacman.d/
sudo cp -f ~/L/etc/*.conf /etc/
sudo pacman -Sy --noconfirm
sudo pacman -Syu --noconfirm

echo "
###############################################################################
# Installing essential software
###############################################################################
"

PKGS=(
'base-devel'
'musl'
'gperftools'
'graphite'
'harfbuzz'
'guile'
'icu'
'bison'
'jemalloc'
'libclc'
'libelf'
'libffi'
'zstd'
'dkms'
'kwin-lowlatency'
'gtk4'
'libxcvt'
'libunwind'
'libunistring'
'libxcvt'
'bc'
'ccache'
'pahole'
'paru'
'yay'
'spirv-tools'
'spirv-headers'
'mesa'
'ninja'
'cpio'
'cachyos-settings'
'boost'
'boost-libs'
'extra-cmake-modules'
'firefox-developer-edition'
'meson'
'neofetch'
'lolcat'
'python-setuptools'
'rust'
'zsh'
'zsh-completions'
'kvantum'
'asp'
'pamac-aur'
'p7zip'
'ark'
'unarchiver'
'unrar'
'llvm-git'
'llvm-libs-git'
'llvm-ocaml-git'
'libc++'
'libc++abi'
'cachyos-settings'
'cachyos-rate-mirrors'
'realvnc-vnc-server'

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    yes | sudo pacman -S "$PKG" --needed
done

echo "
###############################################################################
# Configuring Remote Access
###############################################################################
"

sudo vnclicense -add 4LHDB-74D48-7KZ2S-GWMNH-8X9K3
sudo vncserver-x11 -service -joinCloud eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJwbGF0Zm9ybS1lbnRlcnByaXNlLXBvcnRhbDp0b2NVQTM1Z1U3TE5heEZidmlEIiwic3ViIjoibUVkT1VGUlFiYW5XNHBmWVg2cyIsImF1ZCI6ImNyZWF0ZS1zZXJ2ZXIiLCJpZCI6IjVkUjlnWkZncm1XdndmMXk3ZkR2IiwiaWF0IjoxNjQyMTUzNTIxfQ.P1Uwa_fUJgq2XTCKvZw0TTwjhTMCZc_P-nbKdRdAEWc
sudo systemctl start vncserver-x11-serviced.service
sudo systemctl enable vncserver-x11-serviced.service


echo "
###############################################################################
# Installing AUR Software
###############################################################################
"

PKGS=(
'lightly-git'
'lightlyshaders-git'
'papirus-icon-theme'
'ttf-meslo-nerd-font-powerlevel10k'
'nerd-fonts-terminus'
)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm --needed $PKG
done


echo "
###############################################################################
# Applying Theme & Applying ZSH Configurations
###############################################################################
"

yay -S makepkg-optimize --noconfirm
sudo cp -f ~/L/etc/makepkg-optimize.conf /etc/
git config --global user.name Lukas0120
git config --global user.email Lukas.swe@hotmail.com
sleep 2
cd ~
#Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
#Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cp -f ~/L/aliases.zsh ~/.oh-my-zsh/custom/
sudo cp -f ~/L/home/.p10k.zsh /home/lulle/
sudo cp -f ~/L/home/.zshrc /home/lulle/
sudo cp -Rf ~/L/config/.config ~/
sudo cp -f ~/L/local/zsh.profile ~/.local/share/konsole/
sleep 2
cd ~
#chsh -s $(which zsh)



echo "
###############################################################################
# Configuring Zenpower & Services
###############################################################################
"

sudo systemctl enable bluetooth
sudo systemctl start bluetooth


echo "
###############################################################################
# Configuring Locale
###############################################################################
"

sudo sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen
sudo timedatectl --no-ask-password set-timezone Europe/Stockholm
sudo timedatectl --no-ask-password set-ntp 1
sudo localectl --no-ask-password set-locale LANG="en_US.UTF-8" LC_TIME="en_US.UTF-8"


echo "
###############################################################################
# Configuring Kernel
###############################################################################
"

cd ~/L
sudo pacman -U *.pkg.tar.zst --noconfirm
cd

echo "
###############################################################################
# Cloning essential repos
###############################################################################
"
git clone https://github.com/h0tc0d3/arch-packages.git
git clone https://github.com/cachyos/linux-cachyos.git
git clone https://github.com/clangbuiltlinux/tc-build.git
sleep 2
cd /home/lulle/tc-build
wget http://lullemannen.com/llvm/llvm.tar.zst
unzstd llvm.tar.zst
tar xvf llvm.tar
sleep 3
cd ~
cd ~/L/nvidia-all
makepkg -si --skipinteg --noconfirm

echo "
###############################################################################
# Done - export PATH=/home/lulle/tc-build/install/bin:${PATH} #
###############################################################################
"
