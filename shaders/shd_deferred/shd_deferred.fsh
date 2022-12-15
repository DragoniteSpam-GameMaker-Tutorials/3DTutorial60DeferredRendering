varying vec2 v_vTexcoord;

uniform sampler2D samp_Normal;
uniform sampler2D samp_Depth;

uniform float u_CameraZFar;

vec3 GetNormalFromColor(vec3 color) {
    return (color - 0.5) * 2.0;
}

const vec3 UNDO = vec3(1.0, 256.0, 65536.0) / 16777215.0 * 255.0;
float GetDepthFromColorLinear(vec3 color) {
    return dot(color, UNDO) * u_CameraZFar;
}

void main() {
    vec4 col_diffuse = texture2D(gm_BaseTexture, v_vTexcoord);
    vec4 col_normal = texture2D(samp_Normal, v_vTexcoord);
    vec4 col_depth = texture2D(samp_Depth, v_vTexcoord);
    
    vec3 fragment_normal = GetNormalFromColor(col_normal.rgb);
    float fragment_depth = GetDepthFromColorLinear(col_depth.rgb);
    
    gl_FragColor = col_normal;
}
