#version 120

#pragma optionNV(inline all)

#define DISPLAY_SIZE vec2(viewWidth, viewHeight)
#define MOSAIC_COUNT 32
#define MOSAIC_SIZE (viewWidth / MOSAIC_COUNT)
#define RENDER_RATE 8

uniform sampler2D gcolor;
uniform float viewWidth;
uniform float viewHeight;

varying vec2 texcoord;

void main() {
	// モザイク後ピクセル位置(0.0-1.0)
//	vec2 mosaicedLoc = floor(texcoord * DISPLAY_SIZE / MOSAIC_SIZE/* + vec2(0.5, 0.5)*/) / DISPLAY_SIZE * MOSAIC_SIZE;
	// モザイク単位の位置 整数
//	vec2 mosLoc = floor(DISPLAY_SIZE / MOSAIC_SIZE);
	// モザイク前の位置 ピクセル
	vec2 pixeledTex = texcoord * DISPLAY_SIZE;
	// モザイクの元色位置 モザイク単位
	vec2 mosaicedMos = floor(pixeledTex / MOSAIC_SIZE);
	// モザイクの元色位置 ピクセル単位
	vec2 mosaicedLoc = mosaicedMos * MOSAIC_SIZE;

	vec3 color = vec3(0.0);
	for(int u = 0; u < MOSAIC_SIZE; u+=RENDER_RATE) {
		for(int v = 0; v < MOSAIC_SIZE; v+=RENDER_RATE){
			color += texture2D(gcolor, (mosaicedLoc + vec2(u, v)) / DISPLAY_SIZE).rgb * pow(RENDER_RATE, 2);
		}
	}
	/*
	// モザイクの元色位置 ピクセル単位
	// vec2 mosaicedLoc = mosaicedMos * MOSAIC_SIZE;
	*/

	/*
	vec3 diffuse = texture2D(gcolor, mosaicedLoc).rgb;
	gl_FragData[0] = vec4(diffuse, 1.0);
	*/
	gl_FragData[0] = vec4(color / pow(MOSAIC_SIZE, 2), 1.0);
}