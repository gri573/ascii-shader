#version 120
#include "lib/settings.glsl"
uniform sampler2D gcolor;
uniform sampler2D depthtex2;
uniform float viewWidth, viewHeight, aspectRatio;

varying vec2 texcoord;

void main() {
	float fontsize = FONT_SIZE;
	vec2 lettercoord = texcoord * vec2(2 / fontsize * viewWidth, 1 / fontsize * viewHeight);
	vec2 olc = floor(lettercoord); //which letter
	vec2 ilc = lettercoord - olc; //where in the letter
	olc += 0.5;
	olc /= vec2(viewWidth, viewHeight);
	vec3 color = texture2D(gcolor, olc).rgb;
	float b = pow(max(max(color.r, color.g), color.b), 0.65);//(color.r + color.g + color.b) * 0.8;
	float lettercount = 5.0;
	float isletter = clamp(floor(2 * b) - (2 * floor(2 * b) - 1) * texture2D(depthtex2, vec2(0, 1) + vec2(1 / lettercount, -1) * (ilc + vec2(floor(lettercount - lettercount * clamp(abs(2 * b - 1), 0, 1)), 0))).r, 0, 1);
	color /= max(max(color.r, color.g), color.b);
	color *= isletter;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}
