shader_type canvas_item;

uniform vec2 resolution = vec2(320.0, 240.0); // Low-res PSX-like resolution
uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

void fragment() {
    // Snap UV coordinates to a low-res grid for pixelation
    vec2 uv = floor(SCREEN_UV * resolution) / resolution;
    // Sample the screen texture at the pixelated UV
    COLOR = texture(screen_texture, uv);
}