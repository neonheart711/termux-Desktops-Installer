#!/data/data/com.termux/files/usr/bin/bash
set -e

G='\033[1;32m'
Y='\033[1;33m'
C='\033[1;36m'
R='\033[1;31m'
NC='\033[0m'

clear
echo -e "${C}>>> AMAN DESKTOP INSTALLER <<<${NC}"

# ===== BASIC SETUP =====
touch ~/.hushlogin
termux-setup-storage || true
apt update -y || true
apt upgrade -y
apt install x11-repo -y
apt install termux-x11-nightly -y
apt install tur-repo -y
apt install pulseaudio -y
apt install proot-distro -y
apt install wget -y
apt install git -y
pd install debian
wget -O debian https://raw.githubusercontent.com/neonheart711/Termux-Desktops-Installer/main/scripts/debianStartXfce4
chmod 777 debian
mv ~/debian /data/data/com.termux/files/usr/bin/debian
# Desktop Setup 
clear
echo -e "${C}Debian Proot Distros:${NC}"

proot-distro login debian --shared-tmp -- /bin/bash -c "apt update -y && apt install nano sudo xfce4 -y&& sudo apt upgrade -y"



