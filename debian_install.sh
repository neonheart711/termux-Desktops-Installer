#!/data/data/com.termux/files/usr/bin/bash
set -e

# ============================================================
#   COLOR PALETTE
# ============================================================
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

BLACK='\033[0;30m'
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

termux-setup-storage 2>/dev/null || print_warn "Storage setup skipped (may need manual grant)"
print_ok "Storage permission requested"

# ----- System Update -----
print_step "Updating & Upgrading Packages"
apt update -y | tail -1 && print_ok "Package list updated"
apt upgrade -y | tail -1 && print_ok "Packages upgraded"

# ----- Repos & Core Packages -----
print_step "Installing Required Repositories & Packages"

declare -a PKGS=("x11-repo" "termux-x11-nightly" "tur-repo" "pulseaudio" "proot-distro" "wget" "git")

for pkg in "${PKGS[@]}"; do
    apt install "$pkg" -y | tail -1
    print_ok "Installed: ${CYAN}$pkg${RESET}"
done

# ----- Debian Proot -----
print_step "Installing Debian Proot Distro"
pd install debian || print_warn "Debian may already be installed, continuing..."
print_ok "Debian proot distro ready"

# ----- Startup Script -----
print_step "Downloading Debian XFCE4 Launcher"
LAUNCHER_URL="https://raw.githubusercontent.com/neonheart711/Termux-Desktops-Installer/main/scripts/debianStartXfce4"
LAUNCHER_PATH="/data/data/com.termux/files/usr/bin/debian"

wget -q --show-progress -O ~/debian "$LAUNCHER_URL"
chmod 755 ~/debian
mv ~/debian "$LAUNCHER_PATH"
print_ok "Launcher installed at: ${CYAN}debian${RESET} (run anywhere)"

# ----- Desktop Inside Debian -----
print_step "Setting Up XFCE4 Desktop Inside Debian"
echo ""
print_info "Logging into Debian proot — this may take a few minutes..."
echo ""

proot-distro login debian --shared-tmp -- /bin/bash -c "
    echo '' &&
    echo '  Installing desktop packages inside Debian...' &&
    apt update -y | tail -1 &&
    apt install -y nano sudo xfce4  | tail -5 &&
    apt upgrade -y | tail -1 &&
    echo '' &&
    echo '  ✔  XFCE4 Desktop installed successfully inside Debian!'
"

# ----- Done -----
echo ""
print_line
echo ""
echo -e "${GREEN}${BOLD}  ✔  INSTALLATION COMPLETE!${RESET}"
echo ""
print_info "Start your desktop anytime by running:  ${CYAN}${BOLD}debian${RESET}"
print_info "Make sure Termux:X11 app is running before launching."
echo ""
print_line
echo -e "  ${DIM}Script by ${CYAN}neonheart711${RESET}  ${DIM}│  https://github.com/neonheart711${RESET}"
print_line
echo ""
