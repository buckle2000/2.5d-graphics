vec4 position(mat4 transform_projection, vec4 vertex_position) {
	vec4 transformed = transform_projection * vertex_position;
	transformed.y *= 0.8;
	return transformed;
}