shader_type spatial;

uniform vec2 HEIGHTMAP_SIZE = vec2(1024.0, 1024.0);
uniform float UV_SCALE = 1.0;
uniform float HEIGHT_SCALE = 32;
uniform vec3 COLOUR;

uniform sampler2D heightmap;
varying float color_height;

float noise(in vec2 p) {
    return fract(sin(dot(p.xy,vec2(12.9898,78.233)))*43758.5453123);
}

float get_height(vec2 pos) {
	pos -= .5 * HEIGHTMAP_SIZE;
	pos /= HEIGHTMAP_SIZE;
	return texture(heightmap, pos).r;
}

void vertex() {
    vec2 vpos = VERTEX.xz * UV_SCALE;
    float npos_diff = 0.2;
    float h = get_height(vec2(vpos.x, vpos.y)) * HEIGHT_SCALE;
    color_height = h;
    VERTEX.y = h;
    TANGENT = normalize( vec3(0.0, get_height(vpos + vec2(0.0, npos_diff)) - get_height(vpos + vec2(0.0, -npos_diff)), npos_diff*2.));
    BINORMAL = normalize( vec3(npos_diff*2., get_height(vpos + vec2(npos_diff, 0.0)) - get_height(vpos + vec2(-npos_diff, 0.0)), 0.0));
    NORMAL = cross(TANGENT, BINORMAL);
}

void fragment() {
    float ran = noise(UV * UV_SCALE);
    vec3 acolor = COLOUR;
    
    TRANSMISSION = acolor * vec3(1.5, 1.5, 0.5);
    SPECULAR = 0.;
    ROUGHNESS = .8;
    METALLIC = 0.;
    ALBEDO = acolor * (color_height * .2); 
}