shader_type canvas_item;

uniform float speed: hint_range(0.0, 25.0) = 4.0;
uniform float distortion_strength: hint_range(0.0, 10.0) = 3.0;

void vertex() {
  float steps = floor(fract(TIME) * speed) / speed;
  VERTEX.x += cos((steps * 20.0) + VERTEX.x + VERTEX.y) * distortion_strength;
  VERTEX.y += cos((steps * 20.0) + VERTEX.x + VERTEX.y) * distortion_strength;
}