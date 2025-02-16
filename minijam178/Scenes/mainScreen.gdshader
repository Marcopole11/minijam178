shader_type canvas_item;

uniform float cordX = 0.1;
uniform float cordY = 0.1;
uniform float resize = 1;

void vertex() {
	UV.x = (UV.x * resize) + cordX;
	UV.y = (UV.y * resize) + cordY;
}
