# AGY Operational Workflow

Detailed step-by-step lifecycle for system modifications, configuration maintenance, and git synchronization.

---

## 🔄 Lifecycle Stages

```text
[System Modification / Fix]
          │
          ▼
 [Pre-Commit Verification]
  - Check syntax (bash -n, json/yaml validation)
  - Verify portable paths ($HOME vs absolute user paths)
  - Run secret and cache scanner
          │
          ▼
   [Granular Staging]
  - Group files by functional domain (hypr, waybar, shell, packages, etc.)
          │
          ▼
   [Standardized Commit]
  - Format: AGY: <concise summary>
          │
          ▼
   [Immediate Push]
  - git push origin <branch>
```

---

## 📋 Commit Domains & Scope

| Domain | Files / Paths | Example Commit |
|---|---|---|
| Window Manager | `configs/hypr/**` | `AGY: Update Hyprland window rules and keybindings` |
| Status Bar | `configs/waybar/**` | `AGY: Adjust Waybar module spacing and layout` |
| Terminal & Shell | `configs/kitty/**`, `configs/zsh/**`, `configs/fish/**` | `AGY: Update Zsh aliases and starship prompt config` |
| Application Styling | `configs/gtk*/**`, `configs/qt*/**`, `configs/rofi/**` | `AGY: Refine Rofi theme and GTK dark mode settings` |
| System Packages | `packages/pacman.txt`, `packages/aur.txt` | `AGY: Update pacman and aur package inventories` |
| Automations | `scripts/**` | `AGY: Enhance link-configs backup mechanism` |
| Documentation | `README.md`, `AGY/**` | `AGY: Update documentation and keybindings guide` |

---

## 🔒 Security Verification Checklist

- [x] No private keys (`id_rsa`, `id_ed25519`, `*.pem`, `*.key`)
- [x] No authentication tokens, bearer headers, or credentials
- [x] No volatile runtime files (`.cache/`, `.zsh_history`, `.bash_history`)
- [x] No hardcoded username paths when `$HOME` or relative paths apply
