#!/usr/bin/env bash

# ============================================================
#   COLOR & STYLE DEFINITIONS
# ============================================================
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'

BG_BLACK='\033[40m'
BG_BLUE='\033[44m'
BG_CYAN='\033[46m'

# ============================================================
#   UTILITY FUNCTIONS
# ============================================================
print_line() {
    echo -e "${DIM}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

print_step() {
    echo ""
    echo -e "${BG_BLUE}${WHITE}${BOLD}  ➤  $1  ${RESET}"
    echo ""
}

print_ok() {
    echo -e "  ${GREEN}${BOLD}✔${RESET}  ${GREEN}$1${RESET}"
}

print_warn() {
    echo -e "  ${YELLOW}${BOLD}⚠${RESET}  ${YELLOW}$1${RESET}"
}

print_err() {
    echo -e "  ${RED}${BOLD}✘${RESET}  ${RED}$1${RESET}"
}

print_info() {
    echo -e "  ${CYAN}◈${RESET}  ${WHITE}$1${RESET}"
}

# ============================================================
#   BANNER  —  neonheart711
# ============================================================
show_banner() {
    clear
    echo ""
    echo -e "${CYAN}${BOLD}"
    echo "  ███╗   ██╗███████╗ ██████╗ ███╗   ██╗"
    echo "  ████╗  ██║██╔════╝██╔═══██╗████╗  ██║"
    echo "  ██╔██╗ ██║█████╗  ██║   ██║██╔██╗ ██║"
    echo "  ██║╚██╗██║██╔══╝  ██║   ██║██║╚██╗██║"
    echo "  ██║ ╚████║███████╗╚██████╔╝██║ ╚████║"
    echo "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝"
    echo -e "${RESET}"
    echo -e "${MAGENTA}${BOLD}  ██╗  ██╗███████╗ █████╗ ██████╗ ████████╗${RESET}"
    echo -e "${MAGENTA}${BOLD}  ██║  ██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝${RESET}"
    echo -e "${MAGENTA}${BOLD}  ███████║█████╗  ███████║██████╔╝   ██║   ${RESET}"
    echo -e "${MAGENTA}${BOLD}  ██╔══██║██╔══╝  ██╔══██║██╔══██╗   ██║   ${RESET}"
    echo -e "${MAGENTA}${BOLD}  ██║  ██║███████╗██║  ██║██║  ██║   ██║   ${RESET}"
    echo -e "${MAGENTA}${BOLD}  ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝  ${RESET}"
    echo ""
    print_line
    echo -e "  ${CYAN}◈${RESET}  ${WHITE}${BOLD}neonheart711 DESKTOP INSTALLER${RESET}  ${DIM}│  by ${CYAN}neonheart711${RESET}"
    echo -e "  ${CYAN}◈${RESET}  ${DIM}Debian Proot + XFCE4 on Termux${RESET}"
    print_line
    echo ""
    sleep 1
}

# ============================================================
#   MAIN INSTALLER
# ============================================================
show_banner

# ----- Storage & hushlogin -----
print_step "Setting Up Termux Environment"
touch ~/.hushlogin
print_ok "Created ~/.hushlogin (silent login)"

termux-setup-storage
print_ok "Storage permission check completed"

# ----- System Update -----
print_step "Updating & Upgrading Termux Packages"
pkg update -y
pkg upgrade -y
print_ok "Termux base packages updated successfully"

# ----- Repos & Core Packages -----
print_step "Installing Required Repositories & Packages"

declare -a PKGS=("x11-repo" "termux-x11-nightly" "tur-repo" "pulseaudio" "proot-distro" "wget" "git")
total_pkgs=${#PKGS[@]}
count=1

for pkg in "${PKGS[@]}"; do
    print_info "[$count/$total_pkgs] Installing ${CYAN}$pkg${RESET}..."
    if pkg install "$pkg" -y; then
        print_ok "Successfully installed: ${CYAN}$pkg${RESET}"
    else
        print_warn "Failed to install: ${CYAN}$pkg${RESET} (check network/mirrors)"
    fi
    ((count++))
    echo ""
done

# ----- Debian Proot -----
print_step "Installing Debian Proot Distro"
if proot-distro list | grep -q "debian.*installed"; then
    print_warn "Debian is already installed, skipping download..."
else
    print_info "Downloading Debian rootfs (full process visible)..."
    proot-distro install debian || { print_err "Failed to install Debian proot"; exit 1; }
fi
print_ok "Debian proot distro is ready"

# ----- Startup Script -----
print_step "Downloading Debian XFCE4 Launcher"
LAUNCHER_URL="https://raw.githubusercontent.com/neonheart711/Termux-Desktops-Installer/main/scripts/debianStartXfce4"
LAUNCHER_PATH="${PREFIX:-/data/data/com.termux/files/usr}/bin/debian"

if wget --show-progress -O "$LAUNCHER_PATH" "$LAUNCHER_URL"; then
    chmod +x "$LAUNCHER_PATH"
    print_ok "Launcher script installed at: ${CYAN}debian${RESET}"
else
    print_err "Failed to download launcher script"
fi

# ----- Desktop Inside Debian -----
print_step "Setting Up XFCE4 Desktop Inside Debian"
print_info "Entering Debian environment to install packages..."
echo ""

proot-distro login debian --shared-tmp -- /bin/bash -c "
    export DEBIAN_FRONTEND=noninteractive
    
    echo -e '\n\033[1;36m==>\033[0m Updating Debian repository lists...'
    apt update -y
    
    echo -e '\n\033[1;36m==>\033[0m Installing Core Tools (nano, sudo)...'
    apt install -y nano sudo
    
    echo -e '\n\033[1;36m==>\033[0m Installing XFCE4 Desktop & Terminal (Full logs enabled)...'
    apt install -y xfce4 xfce4-terminal dbus-x11
    
    echo -e '\n\033[1;36m==>\033[0m Running package upgrade inside Debian...'
    apt upgrade -y
    
    echo -e '\n\033[1;36m==>\033[0m Cleaning package cache...'
    apt clean
"

if [ $? -eq 0 ]; then
    print_ok "XFCE4 Desktop installed successfully inside Debian!"
else
    print_err "An error occurred during Debian desktop package installation."
fi

# ----- Done -----
echo ""
print_line
echo ""
echo -e "${GREEN}${BOLD}  ✔  INSTALLATION COMPLETE!${RESET}"
echo ""
print_info "Start your desktop anytime by running:  ${CYAN}${BOLD}debian${RESET}"
print_info "Make sure Termux:X11 app is opened before running the command."
echo ""
print_line
echo -e "  ${DIM}Script by ${CYAN}neonheart711${RESET}  ${DIM}│  https://github.com/neonheart711${RESET}"
print_line
echo ""
