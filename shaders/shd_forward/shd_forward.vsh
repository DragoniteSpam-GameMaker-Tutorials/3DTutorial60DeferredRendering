attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec2 in_Texcoord;
attribute vec4 in_Colour;

varying vec4 v_vColour;
varying vec3 v_vWorldPosition;
varying vec3 v_vWorldNormal;
varying vec2 v_vTexcoord;

void main() {
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 1);
    v_vWorldPosition = (gm_Matrices[MATRIX_WORLD] * vec4(in_Position, 1)).xyz;
    v_vWorldNormal = normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0)).xyz);
    v_vColour = in_Colour;
    v_vTexcoord = in_Texcoord;
}