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
sudo pacman -Syu

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
# Installing essential software
###############################################################################
"

PKGS=(
'bash+clang'
'binutils'
'elfutils+clang'
'gcc'
'gcc-ada'
'gcc-d'
'gcc-fortran'
'gcc-go'
'gcc-libs'
'gcc-objc'
'glib2+clang'
'gperftools+clang'
'graphite+clang'
'guile+clang'
'harfbuzz+clang'
'harfbuzz-icu+clang'
'icu+clang'
'jemalloc+clang'
'js78+clang'
'lib32-gcc-libs'
'lib32-glibc'
'libclc12+clang'
'libdrm+clang'
'libelf+clang'
'libffi+clang'
'libgcrypt'
'libplacebo+clang'
'libseccomp+clang'
'libxcrypt+clang'
'llvm-multistage'
'musl+clang'
'ncurses+clang'
'zlib-ng+clang'
'zstd+clang'
'libunwind'
'libunistring'
'flex'
'libxcvt'
'bison'
'bc'
'ccache'
'realvnc-vnc-server'
'grub-customizer'
'sublime-text-4'
'ttf-meslo-nerd-font-powerlevel10k'
'nerd-fonts-terminus'
'cachyos-settings'
'boost'
'boost-libs'
'rpi-imager'
'extra-cmake-modules'
'firefox-developer-edition'
'meson'
'neofetch'
'lolcat'
'python-setuptools'
'rust'
'zsh'
'zsh-completions'
'dkms'
'paru'
'yay'
'spirv-tools'
'mesa'
'ninja'
'cpio'
'uboot-tools'
'base-devel'
'nvidia-dkms'
'nvidia-utils'
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

sudo vnclicense -add 4LH22-D2RGX-WZR2C-2WV2T-MFMS3
sudo vncserver-x11 -service -joinCloud eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJwbGF0Zm9ybS1lbnRlcnByaXNlLXBvcnRhbDpvc2JVQTZ6ZlBrZzdhdkdRdFZWIiwic3ViIjoiWVg3T1VKOW9qTTh1MXpuQmJqdyIsImF1ZCI6ImNyZWF0ZS1zZXJ2ZXIiLCJpZCI6IldreDZ6S1dDVlZWQzhvOGVQWktqIiwiaWF0IjoxNjM5NDc5MzA2fQ.Eh4OovR4_OAj5H383q6m0TXLERW5nFU20sfDuPa_kLw
sudo systemctl start vncserver-x11-serviced.service
sudo systemctl enable vncserver-x11-serviced.service


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
#Autocomplete
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
#Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cp -f ~/L/aliases.zsh ~/.oh-my-zsh/custom/
sudo cp -f ~/L/home/.* /home/lulle/
sudo cp -Rf ~/L/neofetch ~/.config/
sleep 2
cd ~
chsh -s $(which zsh)

echo "
###############################################################################
# Installing AUR Software
###############################################################################
"

PKGS=(
'lightly-git'
'lightlyshaders-git'
'papirus-icon-theme'
'cpu-x'
'asp'
'zenpower3-dkms'
'konsave'
)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm --needed $PKG
done

echo "
###############################################################################
# Configuring Zenpower & Services
###############################################################################
"

sudo modprobe -r k10temp
sudo bash -c 'sudo echo -e "\n# replaced with zenpower\nblacklist k10temp" >> /etc/modprobe.d/blacklist.conf'
sudo modprobe zenpower
sensors
sleep 3
sudo systemctl enable bluetooth
sudo systemctl start bluetooth


echo "
###############################################################################
# Installing optimized kernel
###############################################################################
"
sudo pacman -S linux-cachyos-bore-lto linux-cachyos-bore-lto-headers --noconfirm
sudo grub-mkconfig -o /boot/grub/grub.cfg
sleep 2
konsave -i $HOME/L/kde/lulle.knsv
sleep 1
konsave -a lulle
echo "
###############################################################################
# Cloning essential repos
###############################################################################
"
git clone https://github.com/h0tc0d3/arch-packages.git
git clone https://github.com/Frogging-Family/nvidia-all.git
git clone https://github.com/cachyos/linux-cachyos.git
git clone https://github.com/clangbuiltlinux/tc-build.git
sleep 2
cd ~
cd ~/arch-packages
./build.sh --install-keys
cd ~
cd ~/tc-build
./build-binutils.py

echo "
###############################################################################
# Done - Please Eject Install Media and Reboot
###############################################################################
"
