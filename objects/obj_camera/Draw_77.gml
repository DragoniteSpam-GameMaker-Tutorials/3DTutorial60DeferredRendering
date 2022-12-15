draw_surface_stretched(self.surf_gbuff_normal, 0, 0, window_get_width(), window_get_height());

var h = surface_get_height(self.surf_gbuff_diffuse);
draw_surface_ext(self.surf_gbuff_diffuse, 0, 0, 0.25, 0.25, 0, c_white, 1);
draw_surface_ext(self.surf_gbuff_normal, 0, h * 0.25, 0.25, 0.25, 0, c_white, 1);
draw_surface_ext(self.surf_gbuff_depth, 0, h * 0.5, 0.25, 0.25, 0, c_white, 1);