//needs letter atlas in depthtex2
const float lettercount = 5;
vec4 letterify(vec4 color, vec2 coord) {
	float b = pow(max(max(color.r, color.g), color.b), 0.65);
	float isletter = clamp(floor(2 * b) - (2 * floor(2 * b) - 1) * texture2D(depthtex2, vec2(0, 1) + vec2(1 / lettercount, -1) * (coord + vec2(floor(lettercount - lettercount * clamp(abs(2 * b - 1), 0, 1)), 0))).r, 0, 1);
}