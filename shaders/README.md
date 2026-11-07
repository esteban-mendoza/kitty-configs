# Shaders

`dim-inactive-windows.pipeline` configures Kitty's rendering pipeline to dim
inactive panes. It uses Kitty's built-in `focus-highlight` shader for brightness
and the custom `inactive-saturation.slang` shader for saturation.

The settings approximate the following WezTerm pane options:

```lua
inactive_pane_hsb = {
    hue = 1.0,
    saturation = 0.75,
    brightness = 0.55,
}
```

`inactive-saturation.slang` is based on Kitty's `focus-highlight` shader and is
licensed under GPL-3.0. See `../LICENSES/GPL-3.0.txt`.
