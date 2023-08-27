shader_type canvas_item;

uniform float transition_time = 0.4;
uniform sampler2D noi ;

void fragment() {
	
	vec2 c_uv = SCREEN_UV*2.0 - vec2(1.0);
	float circ = pow(c_uv.x,2.0) + pow(c_uv.y,2.0);
	circ = clamp(circ,0.0,1.0);
	float noi_v = texture(noi,SCREEN_UV).r*0.5;
	COLOR = vec4(vec3(0.0),smoothstep(transition_time-0.1-noi_v,transition_time,circ));
	// Place fragment code here.
}
