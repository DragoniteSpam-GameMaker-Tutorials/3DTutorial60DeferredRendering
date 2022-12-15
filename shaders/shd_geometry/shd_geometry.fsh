varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying vec3 v_VSNormal;
varying float v_VSDepth;

uniform float u_CameraZFar;

const float DEPTH_SCALE_FACTOR = 16777215.0;
vec3 ToDepthColor(float depth) {
    float normalizedDepth = abs(depth / u_CameraZFar);
    float longDepth = normalizedDepth * DEPTH_SCALE_FACTOR;
    vec3 depthAsColor = vec3(mod(longDepth, 256.0), mod(longDepth / 256.0, 256.0), longDepth / 65536.0);
    depthAsColor = floor(depthAsColor);
    depthAsColor /= 255.0;
    return depthAsColor;
}

vec3 ToNormalColor(vec3 normal) {
    return normal * 0.5 + 0.5;
}

void main() {
    gl_FragData[0] = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragData[1] = vec4(ToNormalColor(v_VSNormal), 1);
    gl_FragData[2] = vec4(ToDepthColor(v_VSDepth), 1);
    
    if (gl_FragData[0].a < 0.1) {
        discard;
    }
}
