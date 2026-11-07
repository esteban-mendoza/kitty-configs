# kitty-configs

A compact, portable Kitty configuration for macOS with a minimal native title
bar, translucent background, inactive-pane dimming, a splits-first layout, and
simple Zsh helpers for creating panes. It also includes macOS-style text
editing shortcuts.

![Kitty with a native title bar and split panes](screenshot.png)

Tested with Kitty 0.50.0 and Zsh 5.9 on macOS.

## Contents

| Path | Purpose |
| --- | --- |
| `kitty.conf` | Kitty appearance, layout, shell integration, and keyboard shortcuts |
| `shaders/` | Custom brightness and saturation shaders for inactive panes |
| `kitty.app.icns` | Custom macOS application icon |
| `shell/kitty-splits.zsh` | One Kitty-only split helper with `sp`, `spr`, and `spl` aliases |
| `powerlevel10k/kitty-integration.zsh` | Optional Powerlevel10k/Kitty integration |
| `screenshot.png` | Preview of the resulting terminal |

## Requirements

- Kitty 0.50.0 or newer. The custom shader API used here is not available in
  older releases.
- Zsh for the pane-splitting aliases.
- macOS for the native title-bar options and the custom application icon. The
  terminal configuration can be adapted for Linux, but the title bar and icon
  sections are macOS-specific.

## Installation

### 1. Clone the repository

```sh
git clone <REPOSITORY_URL> "$HOME/kitty-configs"
cd "$HOME/kitty-configs"
```

### 2. Back up your current Kitty configuration

```sh
mkdir -p "$HOME/.config/kitty/backup"
cp -p "$HOME/.config/kitty/kitty.conf" "$HOME/.config/kitty/backup/" 2>/dev/null || true
cp -p "$HOME/.config/kitty/kitty.app.icns" "$HOME/.config/kitty/backup/" 2>/dev/null || true
```

If you already have a `shaders/` directory, back it up or merge it manually.

### 3. Install the configuration

```sh
mkdir -p "$HOME/.config/kitty/shaders"
cp kitty.conf "$HOME/.config/kitty/kitty.conf"
cp shaders/dim-inactive-windows.pipeline shaders/inactive-saturation.slang \
  "$HOME/.config/kitty/shaders/"
cp kitty.app.icns "$HOME/.config/kitty/kitty.app.icns"
```

Kitty automatically reads `kitty.app.icns` from its configuration directory on
macOS. It overrides the icon at startup; it does not replace the icon inside
`/Applications/kitty.app`.

macOS caches Dock icons. If the old icon remains visible, run:

```sh
rm -f /var/folders/*/*/*/com.apple.dock.iconcache
killall Dock
```

### 4. Load the split helpers in Zsh

Add this line to `~/.zshrc`:

```zsh
source "$HOME/kitty-configs/shell/kitty-splits.zsh"
```

Then reload Zsh:

```zsh
exec zsh
```

The helpers require Kitty's remote control, which is already configured in
`kitty.conf` through:

```conf
allow_remote_control socket-only
listen_on unix:/tmp/kitty
```

### 5. Enable Powerlevel10k integration (optional)

If you use Powerlevel10k, add this line inside `~/.p10k.zsh`, immediately after
the line that starts with `unset -m`:

```zsh
source "$HOME/kitty-configs/powerlevel10k/kitty-integration.zsh"
```

This enables Powerlevel10k's Kitty shell integration only when `TERM` is
`xterm-kitty`, which prevents prompt redraw artifacts during resize.

### 6. Apply the configuration

For most settings:

```sh
kitten @ load-config
```

Window decorations and the application icon are applied at startup. Quit Kitty
and open it again if the title bar does not update.

## Pane shortcuts

Source `shell/kitty-splits.zsh` as described above. It defines a single internal
function, `_kitty_split`, and three aliases:

| Command | Result |
| --- | --- |
| `sp` | Create a pane below the current pane |
| `spr` | Create a pane to the right of the current pane |
| `spl` | Create a pane to the left of the current pane |
| `sp htop` | Create a pane below and run `htop` in it |
| `spr npm run dev` | Create a pane to the right and run a command |
| `spl zsh` | Create a pane to the left and start a new shell |

Each helper uses the current Kitty window, preserves its working directory, and
focuses the new pane. The left split relies on this setting in `kitty.conf`:

```conf
enabled_layouts splits:split_axis=horizontal,...
```

## Keyboard shortcuts

| Shortcut | Action |
| --- | --- |
| `Option+Left` / `Option+Right` | Move backward or forward by one word |
| `Command+Left` / `Command+Right` | Move to the beginning or end of the line |
| `Option+Backspace` | Delete the previous word |
| `Option+Delete` | Delete the next word |
| `Command+Backspace` | Delete from the cursor to the beginning of the line |
| `Command+Z` / `Command+Shift+Z` | Undo / redo |
| `Command++` / `Command+-` | Increase / decrease font size |
| `Command+0` | Reset font size |
| `Command+Option+Left` / `Command+Option+Right` | Previous / next tab |
| `Command+Shift+Left` / `Command+Shift+Right` | Move the current tab left / right |

The text-editing shortcuts send the corresponding readline/Emacs control
sequences, so they work in Zsh and in applications that use readline-style key
bindings.

## Customization

The most useful settings in `kitty.conf` are:

```conf
font_size 13
background_opacity 0.75
initial_window_width 110c
initial_window_height 30c
```

To change the inactive-pane appearance, edit
`shaders/dim-inactive-windows.pipeline`:

```conf
var float INACTIVE_DIM = 0.55
```

`INACTIVE_DIM` is the fraction of the original brightness retained. To change
saturation, edit `INACTIVE_SATURATION` in
`shaders/inactive-saturation.slang`.

To use a different square icon, replace `kitty.app.icns` with another `.icns`
file using the same name, then restart Kitty and clear the Dock cache if needed.

## Notes

- `macos_option_as_alt yes` makes Option behave as Alt inside terminal
  applications. It takes effect after restarting Kitty.
- `hide_window_decorations no` keeps the native macOS title bar so the window can
  be moved, minimized, zoomed, and closed.
- The configuration intentionally leaves the font family at Kitty's default.
  Add `font_family "Your Font"` to `kitty.conf` to use another monospaced font.
- The included icon is only applied on macOS. On other platforms, Kitty ignores
  `kitty.app.icns`.

## Credits

- `kitty.app.icns` is `tahoe/kitty-original.icns` from
  [sodapopcan/kitty-icon](https://github.com/sodapopcan/kitty-icon), copyright
  Andrew Haust, licensed under the MIT License. See
  `LICENSES/kitty-icon-MIT.txt`.
- `shaders/inactive-saturation.slang` is based on Kitty's
  `focus-highlight` shader, copyright Kovid Goyal, licensed under GPL-3.0. See
  `LICENSES/GPL-3.0.txt`.

## License

The configuration files and shell helpers are licensed under the MIT License.
See `LICENSE`. The shader files are licensed separately under GPL-3.0 as noted
above.
