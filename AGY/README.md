<a id="top"></a>

<div align="center">
<a href="https://git.io/typing-svg"><img src="https://readme-typing-svg.demolab.com?font=Blood&weight=300&size=37&duration=3000&pause=100&color=6391a8&background=601D6E00&center=true&vCenter=true&repeat=true&random=FALSO&width=660&height=90&lines=AGY+Workstation+Assistant;Automated+Dotfiles+Sync" alt="Typing SVG"/></a>
</div>

<br>

<p align="center">
  Automated configuration manager, pair programmer, and dotfiles synchronization engine for this Arch Linux workstation.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white" alt="Arch Linux" />
  <img src="https://img.shields.io/badge/Antigravity-4285F4?style=for-the-badge&logo=google&logoColor=white" alt="Antigravity" />
  <img src="https://img.shields.io/badge/Hyprland-00A86B?style=for-the-badge&logo=wayland&logoColor=white" alt="Hyprland" />
  <img src="https://img.shields.io/badge/Git_Automation-F05032?style=for-the-badge&logo=git&logoColor=white" alt="Git Automation" />
</p>

---

## 🎯 Overview

**Antigravity (AGY)** functions as the persistent workstation management agent. It monitors, maintains, and backs up configuration changes across all desktop components, tools, shells, and package inventories on this system.

---

## 📂 Contents

| File | Description |
|---|---|
| [`AGENTS.md`](AGENTS.md) | Agent rules, operating principles, and automated synchronization policies |
| [`WORKFLOW.md`](WORKFLOW.md) | Operational lifecycle, verification checklists, and commit domains |
| [`README.md`](README.md) | Documentation and reference manual for AGY on this workstation |

---

## ⚡ Core Functions & Responsibilities

### 1. Configuration Maintenance
- Keeps configurations for **Hyprland**, **Waybar**, **Kitty**, **Rofi**, **SwayNC**, **Zsh**, **Fish**, **VS Code**, and **Theming** modular, clean, and portable.
- Ensures all paths use relative references or `$HOME` variables to guarantee reproducibility across fresh installs.

### 2. Automated Granular Synchronization
- Automatically captures completed configuration fixes, enhancements, or package additions.
- Splices changes into discrete, domain-specific commits rather than monolithic commits.
- Uses the strict commit message convention:
  ```text
  AGY: <concise summary of what was changed>
  ```
- Automatically pushes each commit to the remote repository (`origin/main`).

### 3. Package Inventory Tracking
- Synchronizes native Arch packages ([`packages/pacman.txt`](../packages/pacman.txt)) and AUR packages ([`packages/aur.txt`](../packages/aur.txt)).
- Synchronizes installed VS Code extensions ([`packages/vscode-extensions.txt`](../packages/vscode-extensions.txt)).
- Keeps the user application catalog ([`packages/APPS.md`](../packages/APPS.md)) up to date.

---

> [!IMPORTANT]
> **Data Hygiene & Security Policy**
> - Passwords, API tokens, SSH private keys, certificates, or authorization credentials are **never** staged or committed.
> - Runtime caches (`.cache/`), browser profiles, histories (`.zsh_history`, `.bash_history`), and logs are strictly excluded via [`.gitignore`](../.gitignore).

> [!TIP]
> **Automated Sync Trigger**
> Whenever any task or fix modifies your configuration or installed packages, AGY automatically stages the changes, verifies cleanliness via `git diff`, commits with `AGY: <description>`, and pushes immediately to GitHub.

> [!NOTE]
> Helper automation scripts are available under [`scripts/`](../scripts/) for deployment (`link-configs.sh`), full system install (`install.sh`), and repository synchronization (`backup.sh`).
