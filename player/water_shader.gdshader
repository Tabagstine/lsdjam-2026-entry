shader_type canvas_item;

uniform float water_depth;
uniform float water_line_scale=1.0;
uniform float water_bob_scale;
uniform float water_bob_speed=1.0;

void fragment(){
	if (vec4(UV, 0.0, 1.0).g>1.0-water_depth*(sin(TIME*water_bob_speed)/water_bob_scale)-water_depth){
		COLOR.g+=0.3;
		COLOR.b+=0.5;
		if (vec4(UV, 0.0, 1.0).g<1.0-water_depth*(sin(TIME*water_bob_speed)/water_bob_scale)-water_depth/water_line_scale){
			COLOR.g+=0.3;
			COLOR.b+=0.3;
		}
	}
}