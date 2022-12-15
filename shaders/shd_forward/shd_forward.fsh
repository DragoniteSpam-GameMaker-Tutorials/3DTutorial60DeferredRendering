varying vec4 v_vColour;
varying vec3 v_vWorldPosition;
varying vec3 v_vWorldNormal;
varying vec2 v_vTexcoord;

#define MAX_LIGHTS_DIRECTION 2
#define MAX_LIGHTS_POINT 2

uniform vec3 u_DirectionalLights[MAX_LIGHTS_DIRECTION];
uniform vec3 u_DirectionalLightColors[MAX_LIGHTS_DIRECTION];
uniform vec4 u_PointLights[MAX_LIGHTS_POINT];
uniform vec3 u_PointLightColors[MAX_LIGHTS_POINT];

uniform vec3 u_LightAmbient;

void main() {
    vec3 lightValue = vec3(u_LightAmbient);
    
    for (int i = 0; i < MAX_LIGHTS_DIRECTION; i++) {
        float NdotL = dot(-v_vWorldNormal, u_DirectionalLights[i]);
        NdotL = max(0.0, NdotL);
        lightValue += NdotL * u_DirectionalLightColors[i];
    }
    
    for (int i = 0; i < MAX_LIGHTS_POINT; i++) {
        float range = u_PointLights[i].w;
        float dist = min(distance(u_PointLights[i].xyz, v_vWorldPosition), range);
        float att = (range - dist) / range;
        
        vec3 direction = normalize(v_vWorldPosition - u_PointLights[i].xyz);
        float NdotL = dot(-v_vWorldNormal, direction);
        NdotL = max(0.0, NdotL);
        
        lightValue += att * NdotL * u_PointLightColors[i];
    }
    
    lightValue = min(vec3(1), lightValue);
    
    vec4 color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    color.rgb *= lightValue;
    
    if (color.a < 0.1) discard;
    
    gl_FragColor = color;
}