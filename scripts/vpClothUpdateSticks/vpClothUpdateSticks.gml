/// @arg render
if( argument0 && texture != -1 ) draw_primitive_begin_texture(pr_linelist, texture);

for( var i = 0; i < ds_list_size(sticks); i++ ) {
    var stick = sticks[| i];
    var a = grid[# array_get(stick[0], 0), array_get(stick[0], 1)];
    var b = grid[# array_get(stick[1], 0), array_get(stick[1], 1)];
    
    if( argument0 ) {
        if( !stick[2] ) { continue; } // Hidden
        draw_set_color(c_blue);
        
        var ax = CAMERA_TO_PROJECTION_PLANE_DISTANCE * a[0] / -a[2];
        var ay = CAMERA_TO_PROJECTION_PLANE_DISTANCE * a[1] / -a[2];
        var bx = CAMERA_TO_PROJECTION_PLANE_DISTANCE * b[0] / -b[2];
        var by = CAMERA_TO_PROJECTION_PLANE_DISTANCE * b[1] / -b[2];
        
        if( global.DEPTH ) {
            var z = max(-a[2], -b[2]);
            
            matrix_set(matrix_world, matrix_build(0, 0, z, 0, 0, 0, 1, 1, 1));
        }
        
        if( texture != -1 ) {
            draw_vertex_texture(ax, ay, 0, 0);
            draw_vertex_texture(ax, ay, 0, 0);
        } else draw_line(ax, ay, bx, by);
    } else {
        var temp = [
            b[0] - a[0], 
            b[1] - a[1], 
            b[2] - a[2]
        ];
        
        var l = sqrt(sqr(temp[0]) + sqr(temp[1]) + sqr(temp[2]));
        var d = (l - stick[3]) * .5;
        
        // Normalize vector
        temp[0] /= l; temp[1] /= l; temp[2] /= l;
        
        // Scale vector
        temp[0] *= d; temp[1] *= d; temp[2] *= d;
        
        if( !a[9] ) { // A isn't pinned
            a[@ 0] += temp[0]; // Add to position
            a[@ 1] += temp[1];
            a[@ 2] += temp[2];
        }
        
        if( !b[9] ) { // B isn't pinned
            b[@ 0] -= temp[0]; // Sub from position
            b[@ 1] -= temp[1];
            b[@ 2] -= temp[2];
        }
    }
}

if( argument0 && texture != -1 ) draw_primitive_end();
