/// @description Insert description here

with (self.player) {
    if (self.mouse_lock) {
        #region regular movement
        self.direction -= (window_mouse_get_x() - window_get_width() / 2) / 10;
        self.pitch -= (window_mouse_get_y() - window_get_height() / 2) / 10;
        self.pitch = clamp(self.pitch, -85, 85);
        
        window_mouse_set(window_get_width() / 2, window_get_height() / 2);
        
        if (keyboard_check_direct(vk_escape)) {
            game_end();
        }
        
        var move_speed = 1;
        var dx = 0;
        var dy = 0;
        
        var xlast = x;
        var ylast = y;
        
        if (keyboard_check(ord("A"))) {
            dx += dsin(direction) * move_speed;
            dy += dcos(direction) * move_speed;
        }
        
        if (keyboard_check(ord("D"))) {
            dx -= dsin(direction) * move_speed;
            dy -= dcos(direction) * move_speed;
        }
        
        if (keyboard_check(ord("W"))) {
            dx -= dcos(direction) * move_speed;
            dy += dsin(direction) * move_speed;
        }
        
        if (keyboard_check(ord("S"))) {
            dx += dcos(direction) * move_speed;
            dy -= dsin(direction) * move_speed;
        }
        
        self.x += dx;
        self.y += dy;
        
        if (keyboard_check_pressed(vk_space)) {
            self.zspeed = 2;
        }
        
        self.z += self.zspeed;
        
        if (self.z < 0) {
            self.z = 0;
            self.zspeed = 0;
        }
        
        self.zspeed -= 0.075;
        
        if (point_distance(xlast, ylast, x, y) > 0.01) {
            self.frame = (self.frame + 0.075) % 3;
            self.face_direction = point_direction(xlast, ylast, x, y);
        } else {
            self.frame = 0;
        }
        
        if (mouse_wheel_up()) {
            self.distance = max(40, self.distance - 5);
        }
        if (mouse_wheel_down()) {
            self.distance = min(160, self.distance + 5);
        }
        #endregion
    }
    
    if (keyboard_check_pressed(vk_tab)) {
        self.mouse_lock = !self.mouse_lock;
    }
}