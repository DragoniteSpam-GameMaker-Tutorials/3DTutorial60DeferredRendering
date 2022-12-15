varying vec2 v_vTexcoord;

uniform sampler2D samp_Normal;
uniform sampler2D samp_Depth;

uniform float u_CameraZFar;

uniform vec3 u_LightDirection;

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
    
    vec4 final_color = col_diffuse;
    
    vec3 fragment_normal = GetNormalFromColor(col_normal.rgb);
    float fragment_depth = GetDepthFromColorLinear(col_depth.rgb);
    
    
    ////////////////////////////////
    // directional light
    ////////////////////////////////
    vec3 light_color = vec3(1);
    
    float NdotL = max(0.0, -dot(fragment_normal, u_LightDirection));
    
    final_color.rgb *= NdotL * light_color;
    
    
    ////////////////////////////////
    // fog
    ////////////////////////////////
    vec3 fog_color = vec3(1);
    float fog_start = 500.0;
    float fog_end = 3000.0;
    
    float fog_fraction = clamp((fragment_depth - fog_start) / (fog_end - fog_start), 0.0, 1.0);
    //final_color.rgb = mix(final_color.rgb, fog_color, fog_fraction);
    
    
    
    
    gl_FragColor = final_color;
}
