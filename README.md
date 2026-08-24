# Ryoku Environment on Ubuntu 24.04 LTS

Reproducible guide for the customization applied to Ubuntu 24.04 LTS with GNOME, Kitty, Bash, Starship, Neovim, Ranger, LazyGit, fzf, btop, VS Code, and Okular.

This version includes the corrections made during the configuration process:

- Kitty 0.32.2 does not use `kitty --debug-config`. Use `Ctrl + Shift + F6` to view the effective configuration.
- In Kitty 0.32.2, keep `notify_on_cmd_finish never`. Do not use `filter_notification`.
- The cursor is kept as a block with `cursor_shape block`, `shell_integration no-cursor`, and `printf '\e[2 q'` in Bash.
- Spacedust was removed from Kitty so there is only one color source.
- The correct value for `color15` is `#eee7df`.
- The Neovim Ryoku theme defines `local colors = {...}` first to avoid `attempt to index global 'colors'`.
- Jupytext uses `goerz/jupytext.nvim`, not `GCBallesteros/jupytext.nvim`, to avoid the healthcheck incompatibility with Neovim 0.12.
- `lazy.nvim` has LuaRocks disabled because this configuration does not need it.
- `blink.cmp` uses the Lua matcher. The `blink_cmp_fuzzy` warning is expected.
- Mason warnings for unused language toolchains can be ignored.
- GTK4/libadwaita is not forced through `GTK_THEME`.
- Local Ryoku themes for VS Code were discarded, and Everforest is used instead.

## 1. Palette

```text
background      #000000
background_alt  #0d0f0d
surface         #151815

foreground      #cdc4ba
foreground_dim  #8f8982
foreground_hi   #eee7df

green           #3f8f71
green_bright    #65b88f
green_dark      #1b3127

red             #c66f6f
yellow          #b59b65
blue            #6f91a8
magenta         #987aa1
cyan            #5a9791
```

## 2. Initial Cleanup

```bash
apt-mark showmanual
```

Large packages:

```bash
dpkg-query -Wf '${Installed-Size}\t${Package}\n' \
  | sort -n \
  | tail -50 \
  | numfmt --field=1 --from-unit=1024 --to=iec
```

Other package managers:

```bash
flatpak list
snap list
pipx list
conda env list
```

Conservative cleanup:

```bash
sudo apt autoremove
sudo apt autoclean
```

Do not mass-purge core system packages.

## 3. GNOME Base

```bash
sudo apt install -y \
  gnome-tweaks \
  gnome-shell-extension-manager \
  papirus-icon-theme
```

```bash
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-viridian-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 11'
```

Verify:

```bash
gsettings get org.gnome.desktop.interface color-scheme
gsettings get org.gnome.desktop.interface gtk-theme
gsettings get org.gnome.desktop.interface icon-theme
gsettings get org.gnome.desktop.interface monospace-font-name
```

## 4. Wallpaper

```bash
mkdir -p ~/Pictures/Wallpapers
```

Save the wallpaper as:

```text
~/Pictures/Wallpapers/ryoku-dark.png
```

Apply:

```bash
gsettings set org.gnome.desktop.background picture-uri-dark \
  "file://$HOME/Pictures/Wallpapers/ryoku-dark.png"

gsettings set org.gnome.desktop.background picture-options 'zoom'
```

## 5. GNOME Shell and Dock

Install Just Perfection from Extension Manager.

Suggested settings:

```text
Activities Button        Off
Accessibility Menu       Off
Background Menu          Off
Workspace Popup          Off

Panel                    On
Clock Menu               On
Quick Settings Menu      On

Panel Position           Top
Panel Height             28
Clock Menu Position      Center
Notification Banner      Top End
Animation                On
```

Ubuntu Dock:

```bash
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 36
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.55
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DOTS'
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'focus-minimize-or-previews'
```

## 6. Kitty

Create:

```bash
mkdir -p ~/.config/kitty
```

### `~/.config/kitty/ryoku.conf`

```conf
background              #000000
foreground              #cdc4ba

cursor                  #3f8f71
cursor_text_color       #000000

selection_background    #1b3127
selection_foreground    #e7e0d8

url_color               #5fae89

color0                  #0d0f0d
color8                  #585b58

color1                  #c66f6f
color9                  #df8a8a

color2                  #3f8f71
color10                 #65b88f

color3                  #b59b65
color11                 #d0b77a

color4                  #6f91a8
color12                 #8eabc0

color5                  #987aa1
color13                 #b194ba

color6                  #5a9791
color14                 #77b6ae

color7                  #cdc4ba
color15                 #eee7df
```

### `~/.config/kitty/kitty.conf`

```conf
# Theme
include ryoku.conf

# Font
font_family             JetBrains Mono
bold_font               auto
italic_font             auto
bold_italic_font        auto
font_size               11.5

# Window
window_padding_width    8
background_opacity      0.94

# Cursor
cursor_shape                    block
cursor_blink_interval           0
cursor_trail                    1
cursor_trail_decay              0.1 0.4
cursor_trail_start_threshold    1

shell_integration               no-cursor

# Tabs
tab_bar_edge                    bottom
tab_bar_style                   fade
tab_fade                        1
active_tab_foreground           #eee7df
active_tab_background           #151815
inactive_tab_foreground         #8f8982
inactive_tab_background         #000000

# Mouse
url_style                       straight

# Notifications
notify_on_cmd_finish            never

# Bell
enable_audio_bell               no
visual_bell_duration            0
window_alert_on_bell            no
bell_on_tab                     no
```

Reload:

```text
Ctrl + Shift + F5
```

View the effective configuration in Kitty 0.32.2:

```text
Ctrl + Shift + F6
```

## 7. Bash, Cursor, Starship, and fzf

Verify:

```bash
ps -p $$ -o comm=
```

Backup:

```bash
cp ~/.bashrc ~/.bashrc.bak
```

Install Starship:

```bash
curl -sS https://starship.rs/install.sh | sh
```

Add to the end of `~/.bashrc`:

```bash
printf '\e[2 q'

eval "$(starship init bash)"

export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type d --hidden --follow --exclude .git"

export FZF_DEFAULT_OPTS="
  --height=55%
  --layout=reverse
  --border=rounded
  --info=inline
  --prompt='> '
  --pointer='>'
  --marker='+'
  --color=bg:#000000
  --color=bg+:#1b3127
  --color=fg:#cdc4ba
  --color=fg+:#eee7df
  --color=hl:#3f8f71
  --color=hl+:#65b88f
  --color=info:#8f8982
  --color=prompt:#3f8f71
  --color=pointer:#65b88f
  --color=marker:#b59b65
  --color=spinner:#5a9791
  --color=header:#6f91a8
  --color=border:#585b58
"

[ -f /usr/share/doc/fzf/examples/completion.bash ] && \
  source /usr/share/doc/fzf/examples/completion.bash

[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && \
  source /usr/share/doc/fzf/examples/key-bindings.bash
```

### `~/.config/starship.toml`

```toml
"$schema" = 'https://starship.rs/config-schema.json'

add_newline = true

format = """
$username\
$hostname\
$directory\
$git_branch\
$git_status\
$conda\
$cmd_duration\
$line_break\
$character"""

palette = "ryoku"

[palettes.ryoku]
background = "#000000"
surface = "#151815"
foreground = "#cdc4ba"
muted = "#8f8982"
green = "#3f8f71"
bright_green = "#65b88f"
red = "#c66f6f"
yellow = "#b59b65"
blue = "#6f91a8"
cyan = "#5a9791"

[username]
show_always = true
style_user = "fg:foreground"
style_root = "fg:red bold"
format = "[$user]($style)"

[hostname]
ssh_only = false
style = "fg:muted"
format = "[@$hostname]($style)  "

[directory]
style = "fg:green bold"
format = "[$path]($style) "
truncation_length = 3
truncate_to_repo = false
home_symbol = "~"
read_only = " 󰌾"

[git_branch]
symbol = " "
style = "fg:bright_green"
format = "[$symbol$branch]($style) "

[git_status]
style = "fg:yellow"
format = "([$all_status$ahead_behind]($style)) "

[conda]
symbol = ""
style = "fg:muted"
format = "[$environment]($style) "
ignore_base = false

[cmd_duration]
min_time = 2000
style = "fg:muted"
format = "[$duration]($style) "

[character]
success_symbol = "[❯](fg:green bold)"
error_symbol = "[❯](fg:red bold)"
vimcmd_symbol = "[❮](fg:green bold)"
```

Reload:

```bash
source ~/.bashrc
```

## 8. Ranger

```bash
ranger --copy-config=rc
ranger --copy-config=rifle
mkdir -p ~/.config/ranger/colorschemes
```

### `~/.config/ranger/colorschemes/ryoku.py`

```python
from ranger.colorschemes.default import Default
from ranger.gui.color import green, cyan, yellow, red, bold


class Scheme(Default):
    def use(self, context):
        fg, bg, attr = Default.use(self, context)

        if context.directory:
            fg = green
            attr |= bold

        if context.link:
            fg = cyan

        if context.executable and not context.directory:
            fg = green
            attr |= bold

        if context.marked:
            fg = yellow
            attr |= bold

        if context.bad:
            fg = red

        if context.selected:
            attr |= bold

        return fg, bg, attr
```

Add to `~/.config/ranger/rc.conf`:

```text
set colorscheme ryoku
set viewmode miller
set column_ratios 1,3,4

set show_hidden false
set confirm_on_delete multiple

set preview_files true
set preview_directories true
set collapse_preview true

set sort natural
set sort_case_insensitive true
set sort_directories_first true

set draw_borders both
set status_bar_on_top false

set vcs_aware true
set vcs_backend_git enabled

set preview_images true
set preview_images_method kitty
```

Add to `~/.config/ranger/rifle.conf`:

```text
ext pdf, has okular, X, flag f = okular -- "$@"
```

## 9. LazyGit

`~/.config/lazygit/config.yml`:

```yaml
gui:
  theme:
    activeBorderColor:
      - "#3f8f71"
      - bold

    inactiveBorderColor:
      - "#585b58"

    searchingActiveBorderColor:
      - "#5a9791"
      - bold

    optionsTextColor:
      - "#6f91a8"

    selectedLineBgColor:
      - "#1b3127"

    inactiveViewSelectedLineBgColor:
      - "#0d0f0d"

    cherryPickedCommitFgColor:
      - "#eee7df"

    cherryPickedCommitBgColor:
      - "#987aa1"

    markedBaseCommitFgColor:
      - "#000000"

    markedBaseCommitBgColor:
      - "#b59b65"

    unstagedChangesColor:
      - "#c66f6f"

  authorColors:
    "*": "#8f8982"

  showFileTree: true
  showListFooter: true
  showRandomTip: false
  showCommandLog: false
  nerdFontsVersion: ""

  border: rounded
```

## 10. btop

Create:

```bash
mkdir -p ~/.config/btop/themes
```

`~/.config/btop/themes/ryoku.theme`:

```conf
theme[main_bg]="#000000"
theme[main_fg]="#cdc4ba"
theme[title]="#eee7df"
theme[hi_fg]="#65b88f"
theme[selected_bg]="#1b3127"
theme[selected_fg]="#eee7df"
theme[inactive_fg]="#585b58"
theme[graph_text]="#8f8982"
theme[meter_bg]="#151815"
theme[proc_misc]="#8f8982"

theme[cpu_box]="#3f8f71"
theme[mem_box]="#5a9791"
theme[net_box]="#6f91a8"
theme[proc_box]="#987aa1"

theme[div_line]="#151815"

theme[temp_start]="#3f8f71"
theme[temp_mid]="#b59b65"
theme[temp_end]="#c66f6f"

theme[cpu_start]="#3f8f71"
theme[cpu_mid]="#65b88f"
theme[cpu_end]="#b59b65"

theme[free_start]="#3f8f71"
theme[free_mid]="#5a9791"
theme[free_end]="#6f91a8"

theme[cached_start]="#6f91a8"
theme[cached_mid]="#5a9791"
theme[cached_end]="#3f8f71"

theme[available_start]="#3f8f71"
theme[available_mid]="#65b88f"
theme[available_end]="#5a9791"

theme[used_start]="#b59b65"
theme[used_mid]="#c66f6f"
theme[used_end]="#df8a8a"

theme[download_start]="#3f8f71"
theme[download_mid]="#5a9791"
theme[download_end]="#6f91a8"

theme[upload_start]="#6f91a8"
theme[upload_mid]="#987aa1"
theme[upload_end]="#c66f6f"

theme[process_start]="#3f8f71"
theme[process_mid]="#b59b65"
theme[process_end]="#c66f6f"
```

In `~/.config/btop/btop.conf`:

```conf
color_theme = "ryoku"
theme_background = False
truecolor = True
```

## 11. VS Code

Everforest is used instead of a local Ryoku theme.

```bash
code --install-extension reesew.everforest-theme
```

Font:

```json
"editor.fontFamily": "'JetBrains Mono', monospace",
"editor.fontSize": 14,
"editor.fontLigatures": true,
"terminal.integrated.fontFamily": "'JetBrains Mono'",
"terminal.integrated.fontSize": 13
```

### Purge Copilot

```bash
pkill code

code --uninstall-extension GitHub.copilot
code --uninstall-extension GitHub.copilot-chat

rm -rf ~/.vscode/extensions/github.copilot-*
rm -rf ~/.vscode/extensions/github.copilot-chat-*
rm -rf ~/.config/Code/CachedExtensionVSIXs/github.copilot*
rm -rf ~/.config/Code/User/globalStorage/github.copilot
rm -rf ~/.config/Code/User/globalStorage/github.copilot-chat

find ~/.config/Code/User/workspaceStorage \
  -type d \
  -name 'GitHub.copilot-chat' \
  -prune \
  -exec rm -rf {} +

rm -rf ~/.config/Code/logs/*
```

Verificar:

```bash
code --list-extensions | grep -i copilot
```

Do not delete files named `copilot` that belong internally to Pylance, Python Environments, or vscode-icons.

## 12. Okular

```bash
sudo apt install -y qt5-gtk-platformtheme
```

Add to `~/.profile`:

```bash
export QT_QPA_PLATFORMTHEME=gtk3
```

Log out and log back in.

In Okular, use this as the document background:

```text
#0d0f0d
```

Optional dark reading mode:

```text
Dark color   #cdc4ba
Light color  #0d0f0d
```

For technical documents with plots or figures, it is better to keep the original colors.

## 13. Lock Screen

```bash
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.screensaver lock-delay 0
gsettings set org.gnome.desktop.notifications show-in-lock-screen false
gsettings set org.gnome.desktop.interface clock-format '24h'
```

Test with:

```text
Super + L
```

## 14. Profile Picture

Use the raven avatar.

Suggested path:

```text
~/Pictures/Avatars/ravencore.jpeg
```

The included folder contains `assets/ravencore-avatar.jpeg` if it was available when the package was created.

## 15. Neovim

### 15.1 Install

```bash
cd /tmp

curl -LO \
  https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

sudo rm -rf /opt/nvim-linux-x86_64

sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

sudo ln -sf \
  /opt/nvim-linux-x86_64/bin/nvim \
  /usr/local/bin/nvim
```

```bash
nvim --version | head -n 1
```

### 15.2 Dependencies

```bash
sudo apt install -y xclip
```

Tree-sitter CLI:

```bash
mkdir -p ~/.local/bin

curl -L \
  https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-cli-linux-x64.zip \
  -o /tmp/tree-sitter.zip

unzip -o /tmp/tree-sitter.zip -d ~/.local/bin
chmod +x ~/.local/bin/tree-sitter

tree-sitter --version
```

### 15.3 Final Structure

```text
~/.config/nvim/
├── init.lua
├── colors/
│   └── ryoku.lua
└── lua/
    ├── config/
    │   ├── keymaps.lua
    │   ├── lazy.lua
    │   └── options.lua
    └── plugins/
        ├── completion.lua
        ├── dap.lua
        ├── explorer.lua
        ├── finder.lua
        ├── formatting.lua
        ├── git.lua
        ├── jupyter.lua
        ├── latex.lua
        ├── lsp.lua
        ├── treesitter.lua
        └── ui.lua
```

Create:

```bash
mkdir -p ~/.config/nvim/{colors,lua/config,lua/plugins}
```

The complete files are in the `nvim/` folder included in the ZIP. That folder contains the final corrected version.

### 15.4 Neovim Python Environment

```bash
python3 -m venv ~/.local/share/nvim/venv

~/.local/share/nvim/venv/bin/python \
  -m pip install --upgrade pip

~/.local/share/nvim/venv/bin/python \
  -m pip install \
  pynvim \
  jupyter_client \
  nbformat
```

```bash
pipx install jupytext
```

For a Conda kernel:

```bash
conda activate mi_entorno

python -m pip install ipykernel

python -m ipykernel install \
  --user \
  --name mi_entorno \
  --display-name "Python (mi_entorno)"
```

### 15.5 Plugins and Mason

```bash
nvim
```

Inside Neovim:

```vim
:Lazy sync
:Mason
:MasonInstall stylua codelldb debugpy
```

Stack:

```text
lazy.nvim
nvim-tree
fzf-lua
gitsigns
lualine
nvim-treesitter
blink.cmp
mason.nvim
nvim-lspconfig
basedpyright
ruff
clangd
texlab
lua_ls
conform.nvim
vimtex
goerz/jupytext.nvim
molten-nvim
nvim-dap
nvim-dap-python
nvim-dap-ui
codelldb
```

### 15.6 Validation

```vim
:checkhealth
:checkhealth vim.lsp
:checkhealth jupytext
:ConformInfo
:LspInfo
```

Warnings that do not block the configuration:

- `blink_cmp_fuzzy lib is not downloaded/built`, because the configured matcher is Lua.
- Mason may warn about Go, Cargo, Composer, PHP, npm, Node, or Julia.
- Molten may warn about optional graphics dependencies.
- `c.doxygen` and `cpp.doxygen` may appear as unknown filetypes.
- `No active clients` is normal when no compatible file is open.

### 15.7 Keybindings

```text
General
Space e       file explorer
Space ff      find file
Space fg      search text
Space fb      buffers
Space f       format
Space w       save
Space q       quit
gd            definition
gD            declaration
gr            references
K             documentation
Space rn      rename
Space ca      code action

LaTeX
\ll           compile
\lv           open PDF
\lc           clean

Jupyter
\mi           kernel
\rl           run line
\r            run visual selection
\rr           rerun cell
\os           show output
\oh           hide output

Debug
F5            continue
F9            breakpoint
F10           step over
F11           step into
F12           step out
```

## 16. Ready-to-Copy Files

The ZIP contains:

```text
ryoku_ubuntu_setup/
├── README.md
├── assets/
├── bash/
│   └── bashrc.additions
├── btop/
│   └── themes/
│       └── ryoku.theme
├── kitty/
│   ├── kitty.conf
│   └── ryoku.conf
├── lazygit/
│   └── config.yml
├── nvim/
│   ├── init.lua
│   ├── colors/
│   │   └── ryoku.lua
│   └── lua/
│       ├── config/
│       └── plugins/
├── ranger/
│   ├── colorschemes/
│   │   └── ryoku.py
│   ├── rc.conf.additions
│   └── rifle.conf.additions
├── scripts/
│   ├── apply_gnome.sh
│   └── apply_user_configs.sh
└── starship/
    └── starship.toml
```

`apply_user_configs.sh` creates a backup before copying Kitty, Neovim, LazyGit, btop, Starship, and the Ranger colorscheme.

```bash
./scripts/apply_user_configs.sh
```

The `*.additions` fragments are added manually so existing configurations are not overwritten.

GNOME:

```bash
./scripts/apply_gnome.sh
```

## 17. Orchis, Requested Final Installation

```bash
sudo apt install -y git sassc gtk2-engines-murrine gnome-themes-extra gnome-tweaks gnome-shell-extensions

cd ~/Downloads
git clone --depth=1 https://github.com/vinceliuice/Orchis-theme.git
cd Orchis-theme

./install.sh -t green -c dark -s standard --tweaks dock -l

gsettings set org.gnome.desktop.interface gtk-theme 'Orchis-Green-Dark'
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gsettings set org.gnome.shell.extensions.user-theme name 'Orchis-Green-Dark'
```
