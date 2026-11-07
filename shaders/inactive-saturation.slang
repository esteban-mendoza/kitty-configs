#language slang 2026

import kitty_custom_shader_types;

// Equivalente aproximado a inactive_pane_hsb.saturation = 0.75 en WezTerm.
static const float INACTIVE_SATURATION = 0.75;
static const bool DIM_CENTRAL_AREA_ONLY = true;
static const bool INCLUDE_WINDOW_PADDING = true;

public float4
fragment_main(float4 color, KittyTextures t, KittyCustomShaderData d) {
    if (DIM_CENTRAL_AREA_ONLY) {
        float4 area = d.central_area;
        if (any(t.pos < area.xy) || any(t.pos > area.xy + area.zw)) return color;
    }

    float4 g = d.active_window_geometry;
    if (g.z <= 0.0 || g.w <= 0.0) return color;

    if (INCLUDE_WINDOW_PADDING) {
        g.xy -= d.active_window_padding.xy;
        g.zw += d.active_window_padding.xy + d.active_window_padding.zw;
    }

    float2 winMin = g.xy;
    float2 winMax = g.xy + g.zw;
    float2 uv = t.pos;
    bool inWindow = all(uv >= winMin) && all(uv <= winMax);
    if (inWindow) return color;

    // Mezclar con luminancia Rec. 709 para reducir la saturación.
    float gray = dot(color.rgb, float3(0.2126, 0.7152, 0.0722));
    return float4(lerp(float3(gray), color.rgb, INACTIVE_SATURATION), color.a);
}
