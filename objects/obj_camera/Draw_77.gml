shader_set(shd_deferred);

shader_set_uniform_f(shader_get_uniform(shd_deferred, "u_CameraZFar"), 16000);

texture_set_stage(shader_get_sampler_index(shd_deferred, "samp_Normal"), surface_get_texture(self.surf_gbuff_normal));
texture_set_stage(shader_get_sampler_index(shd_deferred, "samp_Depth"), surface_get_texture(self.surf_gbuff_depth));
draw_surface_stretched(self.surf_gbuff_diffuse, 0, 0, window_get_width(), window_get_height());
shader_reset();











var h = surface_get_height(self.surf_gbuff_diffuse);
draw_surface_ext(self.surf_gbuff_diffuse, 0, 0, 0.25, 0.25, 0, c_white, 1);
draw_surface_ext(self.surf_gbuff_normal, 0, h * 0.25, 0.25, 0.25, 0, c_white, 1);
draw_surface_ext(self.surf_gbuff_depth, 0, h * 0.5, 0.25, 0.25, 0, c_white, 1);