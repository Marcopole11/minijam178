shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;
uniform sampler2D noise_texture;

uniform float center;
uniform float waves;
uniform float force;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float noise = texture(noise_texture,UV*waves-center).r;
	COLOR = texture(screen_texture,SCREEN_UV + (noise*force)).rgba;
	//vec2 disp = normalize(SCREEN_UV - center)*force;
	//COLOR = texture(screen_texture,SCREEN_UV - disp).rgba;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
