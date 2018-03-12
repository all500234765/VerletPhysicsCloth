/// @arg gridW
/// @arg gridH
/// @arg cellW
/// @arg cellH
W = argument0 + 1;
H = argument1 + 1;

grid = ds_grid_create(W, H);

// Points
for( var i = 0; i < W; i++ ) {
    for( var j = 0; j < H; j++ ) {
        grid[# i, j] = [
            // Position
            600 + argument2 * i, 0, -1500 + argument3 * j, 
            
            // Old pos
            0, 0, 0, 
            
            // Velocity
            0, 0, 0, 
            
            // Pinned
            1*(j == 0 || 0*j == H - 1), 
            
            
        ];
        
        ds_list_add(points, grid[# i, j]);
    }
}

// Sticks Vert
for( var i = 0; i < W; i++ ) {
    for( var j = 0; j < H - 1; j++ ) {
        var a = grid[# i, j];
        var b = grid[# i, j + 1];
        var temp = [
            b[0] - a[0], 
            b[1] - a[1], 
            b[2] - a[2], 
        ];
        
        var l = sqrt(sqr(temp[0]) + sqr(temp[1]) + sqr(temp[2]));
        
        ds_list_add(sticks, [
            [i, j],       // Point 1
            [i, j + 1],   // Point 2
            true,         // Visible
            l,            // Size
        ]);
    }
}

// Sticks Hor
for( var i = 0; i < W - 1; i++ ) {
    for( var j = 0; j < H; j++ ) {
        var a = grid[# i, j];
        var b = grid[# i + 1, j];
        var temp = [
            b[0] - a[0], 
            b[1] - a[1], 
            b[2] - a[2], 
        ];
        
        var l = sqrt(sqr(temp[0]) + sqr(temp[1]) + sqr(temp[2]));
        
        ds_list_add(sticks, [
            [i, j],       // Point 1
            [i + 1, j],   // Point 2
            true,         // Visible
            l,            // Size
        ]);
    }
}
