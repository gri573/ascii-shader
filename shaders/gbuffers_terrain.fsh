#version 120

uniform sampler2D lightmap;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying vec3 normal;
uniform ivec2 atlasSize;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color *= texture2D(lightmap, lmcoord);

/* DRAWBUFFERS:02 */
	gl_FragData[0] = color; //gcolor
	gl_FragData[1] = vec4(normal * 0.5 + vec3(0.5), 1.0);
}