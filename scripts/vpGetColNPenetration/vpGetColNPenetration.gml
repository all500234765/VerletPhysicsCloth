/// @arg {Ball} b
/// @arg {Point} p
var b = argument0;
var p = argument1;

var temp = [
    p[0] - b[0], 
    p[1] - b[1], 
    p[2] - b[2]
];

var l = sqrt(sqr(temp[0]) + sqr(temp[1]) + sqr(temp[2]));

// temp.length() <= radius
if( l <= b[3] ) {
    var d = b[3] - l;
    
    // Normalize vector
    temp[0] /= l; temp[1] /= l; temp[2] /= l;
    
    // Scale vector
    temp[0] *= d; temp[1] *= d; temp[2] *= d;
    
    return temp;
}

return 0;
