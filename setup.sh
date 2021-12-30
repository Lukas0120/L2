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
'base-devel'
'glibc'
'libgcrypt'
'lib32-glibc'
'lib32-gcc-libs'
'libplacebo+clang'
'bash+clang'
'libseccomp+clang'
'binutils'
'libxcrypt+clang'
'elfutils+clang'
'gcc'
'gcc-ada'
'gcc-d'
'gcc-fortran'
'gcc-go'
'gcc-libs'
'gcc-objc'
'llvm-multistage'
'glib2+clang'
'glib2-docs+clang'
'musl+clang'
'gperftools+clang'
'ncurses+clang'
'graphite+clang'
'harfbuzz+clang'
'guile+clang'
'harfbuzz-icu+clang'
'icu+clang'
'jemalloc+clang'
'libdrm+clang'
'libclc12+clang'
'libelf+clang'
'libffi+clang'
'zlib-ng+clang'
'zstd+clang'
'js78+clang'
'makepkg-optimize'
'zramd'
'linux-cachyos-bore-lto'
'linux-cachyos-bore-lto-headers'
'dkms'
'lib32-nvidia-utils-tkg'
'opencl-nvidia-tkg'
'nvidia-utils-tkg'
'nvidia-egl-wayland-tkg'
'nvidia-dkms-tkg'
'nvidia-settings-tkg'
'lib32-opencl-nvidia-tkg'
'xorg-font-util+clang'
'xorg-mkfontscale+clang'
'xcompmgr+clang'
'xorg-fonts-encodings+clang'
'xorg-util-macros+clang'
'xorg-xauth+clang'
'xorg-xkbcomp+clang'
'xtrans+clang'
'xorgproto+clang'
'xorg-setxkbmap+clang'
'konsole+clang'
'kwindowsystem+clang'
'kwin-lowlatency'
'gtk3+clang'
'gtk3-demos+clang'
'gtk3-docs+clang'
'gtk4+clang'
'gtk4-demos+clang'
'plasma-desktop+clang'
'gtk4-docs+clang'
'plasma-framework+clang'
'gtk-update-icon-cache+clang'
'plasma-integration+clang'
'plasma-wayland-session+clang'
'plasma-workspace+clang'
'qt5-base+clang'
'qt5-xcb-private-headers+clang'
'libxcvt+clang'
'libunwind'
'libunistring'
'libxcvt'
'bc'
'ccache'
'pahole'
'paru'
'yay'
'spirv-tools'
'mesa'
'ninja'
'cpio'
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
'tela-icon-theme'
'kvantum'
'asp'
'kwin-bismuth-git'
'mesa'
'pamac-aur'
'p7zip'
'ark'
'unarchiver'
'unrar'

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --needed
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

sudo systemctl enable bluetooth
sudo systemctl start bluetooth


echo "
###############################################################################
# Installing optimized kernel
###############################################################################
"
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
cd /home/lulle/tc-build
wget http://lullemannen.com/lullemannen/install.tar.zst
unzstd install.tar.zst
tar xvf install.tar

echo "
###############################################################################
# Done - export PATH=/home/lulle/tc-build/install/bin:${PATH} #
###############################################################################
"
