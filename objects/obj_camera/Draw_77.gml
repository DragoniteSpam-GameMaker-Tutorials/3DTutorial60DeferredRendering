shader_set(shd_deferred);

shader_set_uniform_f(shader_get_uniform(shd_deferred, "u_CameraZFar"), 16000);

var light_direction = { x: 1, y: 1, z: -1 };
var transformed = matrix_transform_vertex(self.mat_view, light_direction.x, light_direction.y, light_direction.z, 0);
var mag = point_distance_3d(0, 0, 0, transformed[0], transformed[1], transformed[2]);
transformed[0] /= mag;
transformed[1] /= mag;
transformed[2] /= mag;

shader_set_uniform_f(shader_get_uniform(shd_deferred, "u_LightDirection"), transformed[0], transformed[1], transformed[2]);

var light_point = { x: 0, y: 0, z: 160 };
var transformed = matrix_transform_vertex(self.mat_view, light_point.x, light_point.y, light_point.z, 1);

shader_set_uniform_f(shader_get_uniform(shd_deferred, "u_LightPointPosition"), transformed[0], transformed[1], transformed[2]);

var fov_y = 60;
var aspect = -16 / 9;

shader_set_uniform_f(shader_get_uniform(shd_deferred, "u_FOVScale"), dtan(fov_y * aspect / 2), dtan(fov_y / 2));

texture_set_stage(shader_get_sampler_index(shd_deferred, "samp_Normal"), surface_get_texture(self.surf_gbuff_normal));
texture_set_stage(shader_get_sampler_index(shd_deferred, "samp_Depth"), surface_get_texture(self.surf_gbuff_depth));
draw_surface_stretched(self.surf_gbuff_diffuse, 0, 0, window_get_width(), window_get_height());
shader_reset();











var h = surface_get_height(self.surf_gbuff_diffuse);
draw_surface_ext(self.surf_gbuff_diffuse, 0, 0, 0.25, 0.25, 0, c_white, 1);
draw_surface_ext(self.surf_gbuff_normal, 0, h * 0.25, 0.25, 0.25, 0, c_white, 1);
draw_surface_ext(self.surf_gbuff_depth, 0, h * 0.5, 0.25, 0.25, 0, c_white, 1);