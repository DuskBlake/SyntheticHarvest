shader_type spatial;
render_mode cull_disabled;

uniform vec3 color : source_color;
uniform vec3 color2 : source_color;
uniform sampler2D noise;
uniform float noiseScale = 20.0;
uniform sampler2D wind_noise_tx;

global uniform vec3 wind_dir;
global uniform float wind_force;
global uniform float wind_speed;

varying vec3 worldPos;

void vertex() {
	worldPos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	float vertex_color_mask = COLOR.r;
	mat3 inv_model_matrix = inverse(mat3(MODEL_MATRIX));
	vec3 wind_local_dir = normalize(inv_model_matrix * wind_dir);
	float scroll_speed = wind_speed;
	float wind_uv_scale = 0.1;
	vec2 wind_uv = vec2(VERTEX.z * wind_uv_scale + TIME * scroll_speed, VERTEX.y * wind_uv_scale);
	float wind_noise = texture(wind_noise_tx, wind_uv).r;
	wind_noise = 2.0 * wind_noise - 1.0;
	VERTEX += wind_local_dir * wind_force * vertex_color_mask;
	VERTEX.x += wind_noise * 0.5 * wind_force * vertex_color_mask;
}

void fragment() {
	vec3 noiseLevel = texture(noise, worldPos.xz / noiseScale).rgb;
	ALBEDO = mix(color, color2, 1.0- UV.y) * mix(color, color2, noiseLevel.r);
	if (!FRONT_FACING) {
		NORMAL = -NORMAL;
	}
}