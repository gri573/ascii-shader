#version 120
#include "lib/settings.glsl"
uniform sampler2D gcolor;
uniform int isEyeInWater;

varying vec2 texcoord;

void main() {
	vec3 color = vec3(0);
	if (isEyeInWater == 1) {
		color *= vec3(0.5, 0.7, 1);
		color += vec3(0.1, 0.14, 0.2);
	}
	if (isEyeInWater == 2) {
		color *= vec3(1, 0.5, 0.3);
		color += vec3(0.3, 0.15, 0.09);
	}
	float fontsize = FONT_SIZE;
	if(texcoord.x < 2 / fontsize && texcoord.y < 1/fontsize) {
		vec2 lettercoord = texcoord * vec2(fontsize * 0.5, fontsize);
		color = texture2D(gcolor, lettercoord).rgb;
	}

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}