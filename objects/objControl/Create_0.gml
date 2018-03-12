vpClothInit();

// Add test balls
ds_list_add(balls, [
    // Position
    800, 300, -1000, 
    
    // Radius
    150
], [
    // Position
    300, 300, -1000, 
    
    // Radius
    150
]);

//         Create grid 8 by 15 with cell size of 64 by 48
vpClothAddPointsSimple(8,   15,                  64,   48);

// Enable if you wanna see in-depth detail
global.DEPTH = true;

if( global.DEPTH ) {
    gpu_set_ztestenable(true);
    matrix_set(matrix_projection, matrix_build_projection_ortho(1024, 540, 1, 1000));
    gpu_set_zfunc(cmpfunc_lessequal);
    //gpu_set_fog(true, 0, 800, 1000);
}
