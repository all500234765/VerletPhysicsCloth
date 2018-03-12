/// @arg 0=upd;1=updCol;2=render
for( var i = 0; i < W; i++ ) {
    for( var j = 0; j < H; j++ ) {
        var point = grid[# i, j];
        //show_debug_message(point);
        
        // Draw
        if( argument0 == 2 ) {
            if( global.DEPTH ) {
                matrix_set(matrix_world, matrix_build(0, 0, -point[2], 0, 0, 0, 1, 1, 1));
            }
            
            draw_set_color(c_red);
            var px = CAMERA_TO_PROJECTION_PLANE_DISTANCE * point[0] / -point[2];
            var py = CAMERA_TO_PROJECTION_PLANE_DISTANCE * point[1] / -point[2];
            
            draw_ellipse(px - 3, py - 3, px + 3, py + 3, 1);
            
            draw_set_color(-1);
            //draw_text((i * 20) div 540 * (1024 / 3), (i * 20) mod 540, point);
        } else {
            if( point[9] ) { continue; } // Is pinned
            
            if( argument0 == 0 ) {
#region Update
                // Set velocity to position and sub prev one
                point[@ 6] = point[0] - point[3];
                point[@ 7] = point[1] - point[4];
                point[@ 8] = point[2] - point[5];
                
                // Set prev. position to position
                point[@ 3] = point[0];
                point[@ 4] = point[1];
                point[@ 5] = point[2];
                
                // Add velocity to position and add gravity
                point[@ 0] += point[6] + grav[0];
                point[@ 1] += point[7] + grav[1];
                point[@ 2] += point[8] + grav[2];
#endregion
            }
            
            if( argument0 == 1 ) {
#region Update collisions
                // Set velocity to position and sub prev one and then scale it by friction
                point[@ 6] = vpFriction * (point[0] - point[3]);
                point[@ 7] = vpFriction * (point[1] - point[4]);
                point[@ 8] = vpFriction * (point[2] - point[5]);
                
                // Collide with all balls
                for( var z = 0; z < ds_list_size(balls); z++ ) {
                    var ball = balls[| z];
                    var NPenetr = vpGetColNPenetration(ball, point);
                    
                    if( typeof(NPenetr) == "array" ) {
                        // Add penetration to position
                        point[@ 0] += NPenetr[0];
                        point[@ 1] += NPenetr[1];
                        point[@ 2] += NPenetr[2];
                    }
                }
                
                // Collision with ground
                if( point[1] > 540 * 2 ) {
                    point[@ 1] = 540 * 2;
                    
                    // Set new prev. position
                    point[@ 3] += vpFriction * (point[0] - point[3]);
                    point[@ 4] = point[1] + vpRestitution * point[6];
                    point[@ 5] += vpFriction * (point[2] - point[5]);
                }
            }
#endregion
            
        }
    }
}
