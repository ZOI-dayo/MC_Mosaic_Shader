#version 120

#define ASPECT_RATE (vec2(16, 9) * (1920 / 16))
#define MOSAIC_SIZE 50

uniform sampler2D gcolor;

varying vec2 texcoord;

void main() {
	vec2 mosaicedLoc = floor(texcoord * ASPECT_RATE / MOSAIC_SIZE/* + vec2(0.5, 0.5)*/) / ASPECT_RATE * MOSAIC_SIZE;

	vec3 diffuse = texture2D(gcolor, mosaicedLoc).rgb;
	gl_FragData[0] = vec4(diffuse, 1.0);
}