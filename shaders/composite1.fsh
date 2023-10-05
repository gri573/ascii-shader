#version 120
#include "lib/settings.glsl"
uniform sampler2D gcolor;
uniform sampler2D depthtex2;
uniform sampler2D colortex2;
uniform sampler2D depthtex0;
uniform vec3 cameraPosition;
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform float viewWidth, viewHeight, aspectRatio;

varying vec2 texcoord;
const float lettercount = 5.0;

void main() {
	float depth =texture2D(depthtex0, texcoord).r;
	vec4 worldPos = vec4(texcoord * 2 - vec2(1), depth * 2 - 1, 1.0);
	worldPos = gbufferProjectionInverse * worldPos;
	worldPos /= worldPos.w;
	worldPos.xyz = mat3(gbufferModelViewInverse) * worldPos.xyz + cameraPosition + vec3(0.01);
	vec2 lettercoord = texcoord * vec2(2.0 / FONT_SIZE * viewWidth, 1.0 / FONT_SIZE * viewHeight);
	vec2 olc = floor(lettercoord); //which letter
	vec2 ilc = lettercoord - olc; //where in the letter
	vec3 normal = texture2D(colortex2, texcoord).xyz * 2 - vec3(1);
/*	if(depth < 0.99995 && max(max(normal.x, normal.y), normal.z) > -1.0){
		if(abs(normal.x) > max(abs(normal.y), abs(normal.z)) - 0.001) ilc = fract(worldPos.yz * 2);
		if(abs(normal.y) > max(abs(normal.x), abs(normal.z)) - 0.001) ilc = fract(worldPos.xz * 2);
		if(abs(normal.z) > max(abs(normal.x), abs(normal.y)) - 0.001) ilc = fract(worldPos.xy * 2);
	}*/ 
	olc += 0.5;
	olc /= vec2(viewWidth, viewHeight);
	vec3 color = texture2D(gcolor, texcoord).rgb;
	float b = pow(max(max(color.r, color.g), color.b), 0.65);
	float isletter = clamp(floor(2 * b) - (2 * floor(2 * b) - 1) * texture2D(depthtex2, vec2(0, 1) + vec2(1 / lettercount, -1) * (ilc + vec2(floor(lettercount - lettercount * clamp(abs(2 * b - 1), 0, 1)), 0))).r, 0, 1);
	color /= max(max(max(color.r, color.g), color.b), 0.0001);
	color *= isletter;
	//color = fract(worldPos.xyz);

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}
