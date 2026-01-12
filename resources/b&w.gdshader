shader_type canvas_item;

uniform float bw_amount : hint_range(0.0, 1.0) = 0.0;

uniform vec4 blink_color: source_color = vec4(1, 1, 1, 1);
uniform float blink_intensity = 0;


void fragment() {
    vec4 color = texture(TEXTURE, UV);

    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    vec3 bw = vec3(gray);

    color.rgb = mix(color.rgb, bw, bw_amount);
	color = mix(color, blink_color, blink_intensity * color.a);
    COLOR = color;
}