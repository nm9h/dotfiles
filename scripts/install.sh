#!/usr/bin/env bash
# ==============================================================================
# Script: install.sh
# Purpose: Complete workstation restoration and setup for Arch Linux
# ==============================================================================

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGES_DIR="${REPO_DIR}/packages"
SCRIPTS_DIR="${REPO_DIR}/scripts"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

check_arch() {
    if [[ ! -f /etc/arch-release ]]; then
        error "This script is tailored for Arch Linux and Arch-based distributions."
        exit 1
    fi
}

install_pacman_packages() {
    if [[ -f "${PACKAGES_DIR}/pacman.txt" ]]; then
        info "Installing official Pacman packages..."
        sudo pacman -Syu --needed --noconfirm - < "${PACKAGES_DIR}/pacman.txt"
        success "Pacman packages installed."
    else
        warn "pacman.txt not found at ${PACKAGES_DIR}/pacman.txt"
    fi
}

ensure_aur_helper() {
    if command -v yay >/dev/null 2>&1; then
        AUR_HELPER="yay"
    elif command -v paru >/dev/null 2>&1; then
        AUR_HELPER="paru"
    else
        info "No AUR helper found. Installing yay..."
        local tmp_dir
        tmp_dir=$(mktemp -d)
        git clone https://aur.archlinux.org/yay-bin.git "$tmp_dir/yay-bin"
        (cd "$tmp_dir/yay-bin" && makepkg -si --noconfirm)
        rm -rf "$tmp_dir"
        AUR_HELPER="yay"
        success "yay installed successfully."
    fi
}

install_aur_packages() {
    if [[ -f "${PACKAGES_DIR}/aur.txt" ]]; then
        info "Installing AUR packages using ${AUR_HELPER}..."
        "${AUR_HELPER}" -S --needed --noconfirm - < "${PACKAGES_DIR}/aur.txt"
        success "AUR packages installed."
    else
        warn "aur.txt not found at ${PACKAGES_DIR}/aur.txt"
    fi
}

install_vscode_extensions() {
    if command -v code >/dev/null 2>&1 && [[ -f "${PACKAGES_DIR}/vscode-extensions.txt" ]]; then
        info "Installing VS Code extensions..."
        while IFS= read -r ext || [[ -n "$ext" ]]; do
            [[ -z "$ext" || "$ext" =~ ^# ]] && continue
            code --install-extension "$ext" --force >/dev/null 2>&1 || warn "Failed to install VS Code extension: $ext"
        done < "${PACKAGES_DIR}/vscode-extensions.txt"
        success "VS Code extensions installed."
    fi
}

setup_services() {
    info "Enabling essential system services..."
    sudo systemctl enable --now NetworkManager.service 2>/dev/null || true
    sudo systemctl enable --now bluetooth.service 2>/dev/null || true
}

main() {
    echo -e "${BLUE}================================================${NC}"
    echo -e "${BLUE}   Workstation Automated Setup & Restoration    ${NC}"
    echo -e "${BLUE}================================================${NC}"

    check_arch
    install_pacman_packages
    ensure_aur_helper
    install_aur_packages
    
    info "Deploying configuration symlinks..."
    bash "${SCRIPTS_DIR}/link-configs.sh"

    install_vscode_extensions
    setup_services

    echo -e "\n${GREEN}================================================${NC}"
    echo -e "${GREEN}   Workstation Setup Completed Successfully!   ${NC}"
    echo -e "${GREEN}================================================${NC}"
    echo -e "Tip: Log out and log back in, or launch Hyprland to enjoy your configured workstation."
}

main "$@"
