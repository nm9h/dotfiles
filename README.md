<a id="top"></a>

<div align="center">
<a href="https://git.io/typing-svg"><img src="https://readme-typing-svg.demolab.com?font=Blood&weight=300&size=37&duration=3000&pause=100&color=6391a8&background=601D6E00&center=true&vCenter=true&repeat=true&random=FALSO&width=660&height=90&lines=Workstation+Configurations" alt="Typing SVG"/></a>
</div>

<br>

<p align="center">
  Personal Arch Linux dotfiles, system packages, and automated setup scripts.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white" alt="Arch Linux" />
  <img src="https://img.shields.io/badge/Hyprland-00A86B?style=for-the-badge&logo=wayland&logoColor=white" alt="Hyprland" />
  <img src="https://img.shields.io/badge/Kitty-1E1E2E?style=for-the-badge&logo=kitty&logoColor=white" alt="Kitty" />
  <img src="https://img.shields.io/badge/Zsh-F15A24?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Zsh" />
  <img src="https://img.shields.io/badge/VS_Code-007ACC?style=for-the-badge&logo=visual-studio-code&logoColor=white" alt="VS Code" />
</p>

<p align="center">
  <img src="https://i.ibb.co/jvr7KjDJ/screenshot-260607-154437.png" alt="Desktop Screenshot" width="1920" height="1080" />
</p>

---

## 📂 Repository Structure

```text
workstation/
├── AGY/                      # Antigravity agent documentation & sync workflows
│   ├── AGENTS.md             # Active workstation rules & sync policies
│   ├── README.md             # Assistant overview & documentation
│   └── WORKFLOW.md           # Operational lifecycle & commit guide
├── configs/                  # Modular application configurations
│   ├── btop/                 # System resource monitor config
│   ├── fastfetch/            # System information fetcher presets
│   ├── fish/                 # Fish shell config & starship prompt
│   ├── git/                  # Git configuration template
│   ├── gtk-3.0/ & gtk-4.0/   # GTK theming settings
│   ├── hypr/                 # Hyprland WM, keybinds, rules, lockscreens, wallpapers
│   ├── kitty/                # Terminal emulator config and themes
│   ├── Kvantum/ & qt*ct/     # Qt5/Qt6 unified styling
│   ├── nwg-look/             # GTK settings editor config
│   ├── pypr/                 # Pyprland plugins configuration
│   ├── rofi/                 # App launcher, menus, and themes
│   ├── satty/                # Screenshot annotation tool config
│   ├── swaync/               # Notification daemon and center
│   ├── vscode/               # VS Code settings and extensions
│   ├── wal/                  # Pywal color palettes & templates
│   ├── waybar/               # Status bar configs and stylesheets
│   ├── wlogout/              # Session logout menu themes
│   ├── xfce4/ & xsettingsd/  # Desktop integration & xsettings
│   └── zsh/                  # Zsh shell configs, aliases, functions, p10k & starship
├── packages/                 # Explicit package inventories
│   ├── APPS.md               # Curated regular applications catalog
│   ├── aur.txt               # Explicitly installed AUR packages
│   ├── pacman.txt            # Explicitly installed official Pacman packages
│   └── vscode-extensions.txt # VS Code extensions list
├── scripts/                  # Management & automated setup scripts
│   ├── backup.sh             # Sync current system configs back into repo
│   ├── install.sh            # Automated bootstrap & setup for fresh Arch installs
│   └── link-configs.sh       # Safe dotfile symlinker with auto-backups
├── .gitignore                # Excludes runtime caches, secrets, histories, and logs
└── README.md                 # Documentation and user manual
```

---

## ⚡ Quick Start & Installation

### 1. Fresh Arch Linux Installation

To restore the complete setup on a clean Arch Linux machine:

```bash
git clone https://github.com/saadxe8/workstation.git ~/workstation
cd ~/workstation
chmod +x scripts/*.sh
./scripts/install.sh
```

The installer will:
1. Update system databases and install official packages from `packages/pacman.txt`.
2. Ensure `yay` is available and install AUR packages from `packages/aur.txt`.
3. Symlink configuration files into `~/.config/`, `~/.zsh`, `~/.zshrc`, `~/.gitconfig`, etc.
4. Install all VS Code extensions from `packages/vscode-extensions.txt`.
5. Enable essential background services (`NetworkManager`, `bluetooth`).

---

### 2. Deploying Only Configuration Files

If packages are already installed and you only want to link the configuration files:

```bash
cd ~/workstation
./scripts/link-configs.sh
```

> [!NOTE]
> Existing configuration files will automatically be backed up to `~/.dotfiles_backup/<timestamp>` before linking.

---

### 3. Backing Up Active Changes

To synchronize newly installed packages and updated configurations into this repository:

```bash
cd ~/workstation
./scripts/backup.sh
git diff
```

---

## ⌨️ Essential Hyprland Keybindings

| Keybind | Action |
|---|---|
| <kbd>SUPER</kbd> + <kbd>Return</kbd> | Launch Kitty Terminal |
| <kbd>SUPER</kbd> + <kbd>Q</kbd> | Close Active Window |
| <kbd>SUPER</kbd> + <kbd>D</kbd> | Open Rofi Application Launcher |
| <kbd>SUPER</kbd> + <kbd>E</kbd> | Open Nautilus File Manager |
| <kbd>SUPER</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd> | Open Yazi Terminal File Manager |
| <kbd>SUPER</kbd> + <kbd>B</kbd> | Launch LibreWolf Web Browser |
| <kbd>SUPER</kbd> + <kbd>C</kbd> | Launch Visual Studio Code |
| <kbd>SUPER</kbd> + <kbd>V</kbd> | Toggle Floating Window |
| <kbd>SUPER</kbd> + <kbd>F</kbd> | Toggle Fullscreen |
| <kbd>SUPER</kbd> + <kbd>W</kbd> | Cycle / Set Wallpaper |
| <kbd>SUPER</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd> | Open Wallpaper Selector Menu |
| <kbd>SUPER</kbd> + <kbd>X</kbd> | Open Wlogout Session Menu |
| <kbd>SUPER</kbd> + <kbd>Shift</kbd> + <kbd>L</kbd> | Lock Screen (`hyprlock`) |
| <kbd>Print</kbd> | Take Screenshot (`satty` / `grimblast`) |
| <kbd>SUPER</kbd> + <kbd>Shift</kbd> + <kbd>H</kbd> | **Show Keybinds Cheat Sheet** |

---

## 📦 Installed Applications & Packages

- Comprehensive package lists are tracked under [`packages/`](packages/):
  - [`pacman.txt`](packages/pacman.txt) - Official Arch Linux packages.
  - [`aur.txt`](packages/aur.txt) - Arch User Repository packages.
  - [`vscode-extensions.txt`](packages/vscode-extensions.txt) - Visual Studio Code extensions.
  - [`APPS.md`](packages/APPS.md) - Detailed breakdown of everyday applications by category.

---

## 🛡️ Security & Cleanliness Guarantee

- No private keys (`id_rsa`, `id_ed25519`, `*.pem`), authentication tokens, browser databases, or credentials are stored in this repository.
- Runtime caches (`.cache`), command histories (`.bash_history`, `.zsh_history`), and logs are strictly ignored via [`.gitignore`](.gitignore).
