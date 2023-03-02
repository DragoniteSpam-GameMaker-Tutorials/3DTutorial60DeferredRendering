function surface_validate(surface_id, w, h, surface_format = surface_rgba8unorm) {
    if (!surface_exists(surface_id)) {
        return surface_create(w, h, surface_format);
    }
    if (surface_get_width(surface_id) != w || surface_get_height(surface_id) != h || surface_get_format(surface_id) != surface_format) {
        surface_free(surface_id);
        return surface_create(w, h, surface_format);
    }
    return surface_id;
}