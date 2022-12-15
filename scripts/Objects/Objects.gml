function TreeObject(model) constructor {
    var dist = random(1000) + 200;
    var angle = random(2 * pi);
    self.x = dist * cos(angle);
    self.y = -dist * sin(angle);
    self.model = model;
    self.transform = matrix_build(self.x, self.y, 0, 0, 0, 0, 1, 1, 1);
}

function TerrainObject(model) constructor {
    var dist = random(3000) + 2000;
    var angle = random(2 * pi);
    var scale = random_range(10, 20);
    var angle = random(360);
    self.x = dist * cos(angle);
    self.y = -dist * sin(angle);
    self.model = model;
    self.transform = matrix_build(self.x, self.y, random_range(-100, -25), 0, 0, angle, scale, scale, scale);
}

function LargeTerrainObject(model) constructor {
    var dist = random(10000) + 7500;
    var angle = random(2 * pi);
    var scale = random_range(20, 40);
    var angle = random(360);
    self.x = dist * cos(angle);
    self.y = -dist * sin(angle);
    self.model = model;
    self.transform = matrix_build(self.x, self.y, random_range(-250, -100), 0, 0, angle, scale, scale, scale);
}

function FloorObject(model) constructor {
    self.x = 0;
    self.y = 0;
    self.model = model;
    self.transform = matrix_build(self.x, self.y, 0, 0, 0, 0, 1, 1, 1);
}

function PlayerObject() constructor {
    self.x = 50;
    self.y = 50;
    self.z = 0;
    self.zspeed = 0;
    self.direction = 0;
    self.pitch = -30;
    self.face_direction = 180;
    self.distance = 40;
    self.mouse_lock = true;
    self.frame = 0;
    self.is_ghost = false;
};