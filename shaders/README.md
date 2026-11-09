# Shaders

`dim-inactive-windows.pipeline` configures Kitty's rendering pipeline to dim
inactive panes. It uses Kitty's built-in `focus-highlight` shader for brightness
and the custom `inactive-saturation.slang` shader for saturation.

Inactive panes keep 55% of their brightness (`INACTIVE_DIM` in
`dim-inactive-windows.pipeline`) and 75% of their saturation
(`INACTIVE_SATURATION` in `inactive-saturation.slang`). Hue does not change.

`inactive-saturation.slang` is based on Kitty's `focus-highlight` shader and is
licensed under GPL-3.0. See `../LICENSES/GPL-3.0.txt`.
