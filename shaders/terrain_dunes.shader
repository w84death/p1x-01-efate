shader_type spatial;

uniform vec2 HEIGHTMAP_SIZE = vec2(1024.0, 1024.0);
uniform float HEIGHT_FACTOR = 128.0;
uniform float MOUNTAINS_FACTOR = 24.;
uniform float UV_FACTOR = 4.;

varying float color_height;
uniform sampler2D heightmap;
uniform sampler2D noisemap;

float get_height(vec2 pos) {
	pos -= .5 * HEIGHTMAP_SIZE;
	pos /= HEIGHTMAP_SIZE;
	return texture(heightmap, pos).r;
}

void vertex() {
	float h = get_height(VERTEX.xz);
	color_height = h;
    VERTEX.y = h * HEIGHT_FACTOR;
}

void fragment() {
	float ran = texture(noisemap, UV * UV_FACTOR).x;
	vec3 alb = vec3(color_height);
	
	alb.r *= .3 + ran *.3;
	alb.g *= .2 + ran *.3;
	alb.b *= .1 + ran *.2;
	

	SPECULAR = 0.8 * ran;
	ROUGHNESS = 0.6 + 0.2 * ran;
	METALLIC = 0.;
	
	ALBEDO = alb;
}