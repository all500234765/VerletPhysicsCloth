vpRestitution = 1; // .01
vpFriction = .01; // .01

points = ds_list_create();
sticks = ds_list_create();
balls = ds_list_create();

grav = [0, .35, 0];

#macro CAMERA_TO_PROJECTION_PLANE_DISTANCE 800

texture = -1; //sprite_get_texture(sprTexture, 0);
