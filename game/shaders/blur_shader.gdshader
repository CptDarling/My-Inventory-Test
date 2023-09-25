shader_type canvas_item;

uniform float blur: hint_range(0.0, 2.5);
uniform float brightness: hint_range(0.0, 1.0);
uniform vec4 modulate:source_color = vec4(1.0);
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec3 col = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur).rgb;
	COLOR = vec4(mix(col, modulate.rgb, modulate.a), 1.0);
}
