shader_type spatial;

uniform vec2 HEIGHTMAP_SIZE = vec2(1024.0, 1024.0);
uniform float HEIGHT_FACTOR = 128.0;
uniform float MOUNTAINS_FACTOR = 24.;
uniform float RANDOM_UV_FACTOR = 4.;
uniform float GRASS_UV_FACTOR = 4.;

varying float color_height;
uniform sampler2D heightmap;
uniform sampler2D noisemap;
uniform float white_line = 0.8;
uniform float green_line = 0.5;
uniform float ground_line = 0.38;
uniform float blue_line = 0.4;
uniform float GOLDEN_ANGLE_RADIAN = 2.39996;
uniform float WAVES_FACTOR_BIG = 16.;
uniform float WAVES_FACTOR_SMALL = 8.;
uniform int WAVES_ITERAIONS = 4;

float get_height(vec2 pos) {
	pos -= .5 * HEIGHTMAP_SIZE;
	pos /= HEIGHTMAP_SIZE;
	return texture(heightmap, pos).r;
}

vec2 wavedx(vec2 position, vec2 direction, float speed, float frequency, float timeshift) {
	float x = dot(direction, position) * frequency + timeshift * speed;
	float wave = exp(sin(x) - 1.0);
	float dx = wave * cos(x);
	return vec2(wave, -dx);
}

float get_waves(vec2 position, int iterations, float Time){
	float iter = 0.0;
	float phase = 6.0;
	float speed = 2.0;
	float weight = 1.0;
	float w = 0.0;
	float ws = 0.0;
	for(int i=0;i<iterations;i++){
		vec2 p = vec2(sin(iter), cos(iter));
		vec2 res = wavedx(position, p, speed, phase, Time);
		position += normalize(p) * res.y * weight * 0.048;
		w += res.x * weight;
		iter += 12.0;
		ws += weight;
		weight = mix(weight, 0.0, 0.2);
		phase *= 1.18;
		speed *= 1.07;
	}
	return w / ws;
}

void vertex() {
	float h = get_height(VERTEX.xz);
	color_height = h;
	
	float shore_line = step(blue_line, color_height);
	float mountains_line = smoothstep(green_line, white_line, color_height);
	float ran = texture(noisemap, VERTEX.xz * 8.).x * MOUNTAINS_FACTOR;
	h = mix(blue_line, h, shore_line);
	
	float w = get_waves(VERTEX.xz * 0.2, WAVES_ITERAIONS, TIME);
	float anim = mix(w, 0., shore_line);
	h += mix(0., ran * .007, ground_line);
	h = h * HEIGHT_FACTOR + anim;
	float fh = mix(h, h + ran, mountains_line);
	VERTEX.y = fh;
    
    /*TANGENT = normalize( vec3(0.0, get_height(VERTEX.xz + vec2(0.0, 0.2)) - get_height(VERTEX.xz + vec2(0.0, -0.2)), 0.4));
    BINORMAL = normalize( vec3(0.4, get_height(VERTEX.xz + vec2(0.2, 0.0)) - get_height(VERTEX.xz + vec2(-0.2, 0.0)), 0.0));
    NORMAL = cross(TANGENT, BINORMAL);*/
}

void fragment() {
	float ran = texture(noisemap, UV * RANDOM_UV_FACTOR).x;
	float ran2 = texture(noisemap, UV * GRASS_UV_FACTOR * 32.).x;
	vec3 alb = vec3(color_height);
	
	// sand (yellow) vs grass (green)
	float y_line = step(ground_line + ran * .15, color_height);
	alb.r = mix(.6 + ran *.3, 	(.23 - ran * .1) * ran2, 	y_line);
	alb.g = mix(.4 + ran *.2, 	(.9 - ran * .1) * ran2, 	y_line);
	alb.b = mix(.3 + ran *.2, 	(0.1) * ran2, 				y_line);
	
	// rest vs white top
	float g_line = step(green_line + ran * .3, color_height);
	alb.r = mix(alb.r, 1., g_line);
	alb.g = mix(alb.g, 1., g_line);
	alb.b = mix(alb.b, 1., g_line);
	
	// water (blue) vs rest
	float b_line = step(blue_line, color_height);
	alb.r = mix(.0 + ran * .05, 	alb.r, b_line);
	alb.g = mix(.2 + ran * .15, 	alb.g, b_line);
	alb.b = mix(.6, 				alb.b, b_line);
	
	EMISSION = mix(vec3(0.), vec3(.1, .2, 1.), g_line);
	TRANSMISSION = mix(vec3(0.), vec3(.3, .3, 1.), g_line);
	TRANSMISSION += mix(vec3(color_height * ran * 24.), vec3(0.), b_line);
	TRANSMISSION += mix(vec3(.9, .9, .8), TRANSMISSION, g_line);
	
	SPECULAR = mix(1., .1, b_line);
	ROUGHNESS = mix(.6, 0.8, b_line);
	METALLIC = mix(0.5, 0.2, b_line);
	
	ALBEDO = alb;
}