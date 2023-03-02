varying vec2 v_vTexcoord;

uniform sampler2D samp_Normal;
uniform sampler2D samp_Depth;

uniform vec3 u_LightDirection;

uniform vec3 u_LightPointPosition;

vec3 GetNormalFromColor(vec3 color) {
    return (color - 0.5) * 2.0;
}

uniform vec2 u_FOVScale;

vec3 GetPositionFromDepthVS(float depth) {
    vec2 ndc_position = 2.0 * (0.5 - v_vTexcoord);
    vec3 view_space_position = vec3(ndc_position * depth * u_FOVScale, depth);
    return view_space_position;
}

void main() {
    vec4 col_diffuse = texture2D(gm_BaseTexture, v_vTexcoord);
    vec4 col_normal = texture2D(samp_Normal, v_vTexcoord);
    vec4 col_depth = texture2D(samp_Depth, v_vTexcoord);
    
    vec4 final_color = col_diffuse;
    
    vec3 fragment_normal = GetNormalFromColor(col_normal.rgb);
    float fragment_depth = col_depth.r;
    vec3 fragment_position = GetPositionFromDepthVS(fragment_depth);
    
    ////////////////////////////////
    // directional light
    ////////////////////////////////
    vec3 light_color = vec3(1);
    
    float NdotL = max(0.0, -dot(fragment_normal, u_LightDirection));
    
    //final_color.rgb *= NdotL * light_color;
    
    
    ////////////////////////////////
    // directional light
    ////////////////////////////////
    vec3 point_light_color = vec3(1);
    float point_light_range = 400.0;
    
    vec3 L = normalize(u_LightPointPosition - fragment_position);
    float dist = distance(u_LightPointPosition, fragment_position);
    NdotL = max(0.0, dot(fragment_normal, L));
    
    float att = clamp((point_light_range - dist) / point_light_range, 0.0, 1.0);
    
    final_color.rgb *= NdotL * point_light_color * att;
    
    
    ////////////////////////////////
    // fog
    ////////////////////////////////
    vec3 fog_color = vec3(1);
    float fog_start = 500.0;
    float fog_end = 3000.0;
    
    float fog_fraction = clamp((fragment_depth - fog_start) / (fog_end - fog_start), 0.0, 1.0);
    final_color.rgb = mix(final_color.rgb, fog_color, fog_fraction);
    
    
    
    
    gl_FragColor = final_color;
}
