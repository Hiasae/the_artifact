shader_type canvas_item;

uniform sampler2D noi : repeat_enable, filter_nearest_mipmap;
uniform sampler2D noi2 :  repeat_enable, filter_nearest_mipmap;
uniform sampler2D sc : hint_screen_texture;
uniform float timescale : hint_range(0.01, 2.0, 0.01);
uniform float timescale2 : hint_range(0.01, 2.0, 0.01);

vec4 darken(vec4 base, vec4 blend){
	return min(base, blend);
}

vec4 screen(vec4 base, vec4 blend){
	return 1.0 - (1.0 - base) * (1.0 - blend);
}

vec4 overlay(vec4 base, vec4 blend){
	vec4 limit = step(0.5, base);
	return mix(2.0 * base * blend, 1.0 - 2.0 * (1.0 - base) * (1.0 - blend), limit);
}


float noisen(vec2 offset, vec2 uv, float ti ){
	return mix(texture(noi, uv + offset + vec2(ti*timescale,0.0)).r,texture(noi2, uv + offset + vec2(ti*timescale2,0.0)).r,0.5);
}


void fragment() {
	
	float mist = smoothstep(0.4,0.7,noisen(vec2(0.),SCREEN_UV,TIME));
	//float darkspots = smoothstep(0.4,0.7,noisen(vec2(0.01,0.02), SCREEN_UV, TIME) - noisen(vec2(0.),SCREEN_UV,TIME));
	
	vec4 new_col = screen(texture(sc,SCREEN_UV),0.4*vec4(vec3(mist),1.));//vec3(mist),1.));//vec4(vec3(1.0), texture(noi,SCREEN_UV+vec2(TIME*0.05,0.)).r);// + vec4(vec3(0.0), texture(noi,SCREEN_UV+vec2(0.2,0.2)+vec2(TIME*0.05,0.)).r);
	//new_col = vec4(mix(new_col.rgb,vec3(0.9),mist),1.);

	COLOR = new_col;
}
