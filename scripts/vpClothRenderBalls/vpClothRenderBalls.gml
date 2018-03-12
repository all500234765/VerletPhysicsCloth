for( var z = 0; z < ds_list_size(balls); z++ ) {
    var ball = balls[| z];
    
    var ax = CAMERA_TO_PROJECTION_PLANE_DISTANCE * ball[0] / -ball[2];
    var ay = CAMERA_TO_PROJECTION_PLANE_DISTANCE * ball[1] / -ball[2];
    var bx = CAMERA_TO_PROJECTION_PLANE_DISTANCE * (ball[0] + ball[3]) / -ball[2];
    var s = bx - ax;
    
    if( global.DEPTH ) {
        matrix_set(matrix_world, matrix_build(0, 0, -ball[2], 0, 0, 0, 1, 1, 1));
        
        draw_set_color(background_color);
        draw_ellipse(ax - s, ay - s, ax + s, ay + s, 0);
    }
    
    draw_set_color(c_red);
    draw_ellipse(ax - s, ay - s, ax + s, ay + s, 1);
}
