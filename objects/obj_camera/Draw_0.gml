surface_set_target(self.surf_gbuff_diffuse);
surface_set_target_ext(1, self.surf_gbuff_normal);
surface_set_target_ext(2, self.surf_gbuff_depth);

draw_clear(c_black);

var cam = camera_get_active();
var xto = self.player.x;
var yto = self.player.y;
var zto = self.player.z + 16;
var xfrom = xto + self.player.distance * dcos(self.player.direction) * dcos(self.player.pitch);
var yfrom = yto - self.player.distance * dsin(self.player.direction) * dcos(self.player.pitch);
var zfrom = zto - self.player.distance * dsin(self.player.pitch);

self.mat_view = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);

camera_set_view_mat(cam, self.mat_view);
camera_set_proj_mat(cam, matrix_build_projection_perspective_fov(-60, -16 / 9, 1, 16000));
camera_apply(cam);

gpu_set_cullmode(cull_counterclockwise);
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
shader_set(shd_geometry);

shader_set_uniform_f(shader_get_uniform(shd_geometry, "u_CameraZFar"), 16000);
/*
shader_set_uniform_f(shader_get_uniform(shd_forward, "u_LightAmbient"), 0.1, 0.1, 0.1);

var ir3 = 1 / sqrt(3);

var directional_lights = [
    ir3, ir3, -ir3,
    -ir3, ir3, -ir3
];

var directional_light_colors = [
    0.5, 0.5, 0.5,
    0.3, 0.3, 0.3,
];

shader_set_uniform_f_array(shader_get_uniform(shd_forward, "u_DirectionalLights"), directional_lights);
shader_set_uniform_f_array(shader_get_uniform(shd_forward, "u_DirectionalLightColors"), directional_light_colors);

var point_lights = [
    0, 0, 64, 128,
    self.player.x, self.player.y, self.player.z + 16, 128,
];

var point_light_colors = [
    0.5, 0.4, 0.4,
    0.9, 0.6, 0.6,
];

shader_set_uniform_f_array(shader_get_uniform(shd_forward, "u_PointLights"), point_lights);
shader_set_uniform_f_array(shader_get_uniform(shd_forward, "u_PointLightColors"), point_light_colors);
*/
vertex_submit(self.vb_floor, pr_trianglelist, -1);

var duck_angle = ((self.player.direction - self.player.face_direction) + 360) % 360;
if (duck_angle >= 320 || duck_angle < 40) {
    var zrot = 90;
    var spr = duck_front;
} else if (duck_angle >= 220) {
    var zrot = 0;
    var spr = duck_right;
} else if (duck_angle >= 140) {
    var zrot = 90;
    var spr = duck_back;
} else if (duck_angle >= 40) {
    var zrot = 180;
    var spr = duck_left;
}

matrix_set(matrix_world, matrix_build(self.player.x, self.player.y, self.player.z, 0, 0, self.player.face_direction + zrot, 1, 1, 1));
vertex_submit(self.vb_player, pr_trianglelist, sprite_get_texture(spr, floor(self.player.frame)));

var cutoff = dcos(60);

for (var i = 0, n = array_length(self.world_objects); i < n; i++) {
    var object = self.world_objects[i];
    matrix_set(matrix_world, object.transform);
    vertex_submit(object.model, pr_trianglelist, -1);
}

var terrain_tex = sprite_get_texture(spr_terrain, 0);

for (var i = 0,n = array_length(self.terrain_objects); i < n; i++) {
    var object = self.terrain_objects[i];
    matrix_set(matrix_world, object.transform);
    vertex_submit(object.model, pr_trianglelist, terrain_tex);
}

gpu_set_cullmode(cull_noculling);
gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);
shader_reset();
matrix_set(matrix_world, matrix_build_identity());

surface_reset_target();