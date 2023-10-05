#version 120
#include "lib/settings.glsl"
uniform sampler2D gcolor;
uniform int isEyeInWater;
uniform float viewWidth;
uniform float viewHeight;
vec2 view = vec2(viewWidth, viewHeight);

varying vec2 texcoord;

void main() {
	vec3 color = texture2D(gcolor, (floor(texcoord * view / FONT_SIZE) + 0.5) / view * FONT_SIZE).rgb;

	if (isEyeInWater == 1) {
		color *= vec3(0.5, 0.7, 1);
		color += vec3(0.1, 0.14, 0.2);
	}
	if (isEyeInWater == 2) {
		color *= vec3(1, 0.5, 0.3);
		color += vec3(0.3, 0.15, 0.09);
	}

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}
