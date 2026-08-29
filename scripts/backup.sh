#!/usr/bin/env bash
# ==============================================================================
# Script: backup.sh
# Purpose: Sync current system configurations and package lists into workstation repo
# ==============================================================================

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIGS_DIR="${REPO_DIR}/configs"
PACKAGES_DIR="${REPO_DIR}/packages"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }

info "Updating package inventories..."
mkdir -p "${PACKAGES_DIR}"
if command -v pacman >/dev/null 2>&1; then
    pacman -Qneq | sort > "${PACKAGES_DIR}/pacman.txt"
    pacman -Qmeq | grep -v 'yay-debug' | sort > "${PACKAGES_DIR}/aur.txt"
    success "Updated pacman.txt and aur.txt"
fi

if command -v code >/dev/null 2>&1; then
    code --list-extensions | sort > "${PACKAGES_DIR}/vscode-extensions.txt"
    if [[ -d "${CONFIGS_DIR}/vscode" ]]; then
        cp "${PACKAGES_DIR}/vscode-extensions.txt" "${CONFIGS_DIR}/vscode/extensions.txt"
    fi
    success "Updated vscode-extensions.txt"
fi

if [[ -f "${HOME}/.config/Code/User/settings.json" ]]; then
    mkdir -p "${CONFIGS_DIR}/vscode"
    cp "${HOME}/.config/Code/User/settings.json" "${CONFIGS_DIR}/vscode/settings.json"
    success "Updated VS Code settings.json"
fi

success "Workstation backup synchronization complete!"
