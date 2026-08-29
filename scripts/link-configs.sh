#!/usr/bin/env bash
# ==============================================================================
# Script: link-configs.sh
# Purpose: Safely symlink configuration files from workstation to user home
# ==============================================================================

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIGS_DIR="${REPO_DIR}/configs"
BACKUP_DIR="${HOME}/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

link_item() {
    local src="$1"
    local dest="$2"
    local dest_dir
    dest_dir="$(dirname "$dest")"

    if [[ ! -e "$src" ]]; then
        warn "Source does not exist: $src (skipping)"
        return 0
    fi

    # Ensure parent directory exists
    mkdir -p "$dest_dir"

    # If destination already points to target, nothing to do
    if [[ -L "$dest" ]] && [[ "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
        info "Already linked: $dest -> $src"
        return 0
    fi

    # If destination exists (file, directory, or broken symlink), back it up
    if [[ -e "$dest" ]] || [[ -L "$dest" ]]; then
        mkdir -p "$BACKUP_DIR"
        warn "Backing up existing $dest to $BACKUP_DIR/"
        mv "$dest" "$BACKUP_DIR/"
    fi

    ln -s "$src" "$dest"
    success "Linked: $dest -> $src"
}

main() {
    echo -e "${BLUE}=======================================${NC}"
    echo -e "${BLUE}   Deploying Workstation Configs      ${NC}"
    echo -e "${BLUE}=======================================${NC}"

    mkdir -p "${HOME}/.config"

    # Standard XDG .config applications
    local config_dirs=(
        "hypr"
        "waybar"
        "kitty"
        "rofi"
        "swaync"
        "wlogout"
        "btop"
        "fastfetch"
        "satty"
        "pypr"
        "fish"
        "gtk-3.0"
        "gtk-4.0"
        "qt5ct"
        "qt6ct"
        "Kvantum"
        "nwg-look"
        "xsettingsd"
        "wal"
        "xfce4"
    )

    for dir in "${config_dirs[@]}"; do
        if [[ -d "${CONFIGS_DIR}/${dir}" ]]; then
            link_item "${CONFIGS_DIR}/${dir}" "${HOME}/.config/${dir}"
        fi
    done

    # Zsh configuration
    if [[ -d "${CONFIGS_DIR}/zsh" ]]; then
        link_item "${CONFIGS_DIR}/zsh" "${HOME}/.zsh"
        if [[ -f "${CONFIGS_DIR}/zsh/.zshrc" ]]; then
            link_item "${CONFIGS_DIR}/zsh/.zshrc" "${HOME}/.zshrc"
        fi
    fi

    # Git configuration
    if [[ -f "${CONFIGS_DIR}/git/.gitconfig" ]]; then
        link_item "${CONFIGS_DIR}/git/.gitconfig" "${HOME}/.gitconfig"
    fi

    # VS Code User settings
    if [[ -f "${CONFIGS_DIR}/vscode/settings.json" ]]; then
        mkdir -p "${HOME}/.config/Code/User"
        link_item "${CONFIGS_DIR}/vscode/settings.json" "${HOME}/.config/Code/User/settings.json"
    fi

    echo -e "\n${GREEN}All configurations linked successfully!${NC}"
    if [[ -d "$BACKUP_DIR" ]]; then
        echo -e "${YELLOW}Backups stored in: ${BACKUP_DIR}${NC}"
    fi
}

main "$@"
