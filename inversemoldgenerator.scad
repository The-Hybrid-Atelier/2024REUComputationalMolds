// Exposed parameters
length = 68.6;    // [length] = 68.6;    // Length of Arduino Uno in mm
width = 53.4;     // [width] = 53.4;     // Width of Arduino Uno in mm
height = 15.0;    // [height] = 15.0;    // Approximate height of Arduino Uno in mm
tolerance = 0.1;  // [tolerance] = 0.1;  // Tolerance percentage
generate = false; // [generate] = false;  // Part 1 or Part 2 
plaster_wall_width = 10;

// Calculate the adjusted dimensions with tolerance
adj_length = length * (1 + tolerance);
adj_width = width * (1 + tolerance);
adj_height = height * (1 + tolerance);

// Create the box with adjusted dimensions
module parametric_box(h, w, l) {
    translate([plaster_wall_width, plaster_wall_width, -0.01])
        cube([w, l, h]);
}

// Create the red box with adjusted dimensions
module mold_box(h, w, l, scale, colorName) {
    color(colorName)
            cube([w + scale, l+ scale, h+ scale/2]);
}

module plaster_box(){
    // INVERSE MOLD
              
}
module inversebox1(){
    difference(){
        difference(){
            mold_box(adj_height + 1 * (plaster_wall_width), adj_width + 2 * (plaster_wall_width), adj_length + 2 * (plaster_wall_width), 2 * (plaster_wall_width), "blue");

            translate([plaster_wall_width, plaster_wall_width, -0.01])
                difference() {
                    mold_box(adj_height, adj_width, adj_length, 2 * (plaster_wall_width), "red");
                    parametric_box(adj_height, adj_width, adj_length);
                };
        }
        
        // REMOVING PART 2 of the INVERSE MOLD
        translate([plaster_wall_width -1, plaster_wall_width-1, -1.01])
            parametric_box(adj_height + 2, adj_width + 2, adj_length +2);  
    }
}
module inversebox2(){
    intersection(){
        difference(){
            mold_box(adj_height + 1 * (plaster_wall_width), adj_width + 2 * (plaster_wall_width), adj_length + 2 * (plaster_wall_width), 2 * (plaster_wall_width), "blue");

            translate([plaster_wall_width, plaster_wall_width, -0.01])
                difference() {
                    mold_box(adj_height, adj_width, adj_length, 2 * (plaster_wall_width), "red");
                    parametric_box(adj_height, adj_width, adj_length);
                };
        }
        
        // REMOVING PART 2 of the INVERSE MOLD
        translate([plaster_wall_width -1, plaster_wall_width-1, -1.01])
            parametric_box(adj_height + 2, adj_width + 2, adj_length +2);  
    }
}
module top_mold_lid(w, l){
    translate([0, 0, -plaster_wall_width])
        color("green")
            cube([w + plaster_wall_width *  4, l + plaster_wall_width *  4, plaster_wall_width]);
}
 module part2(){
    translate([0, 0, -50])
        union(){
            inversebox2();
            top_mold_lid(adj_width, adj_length);
        }
    }
//inversebox1();
if(generate){
    part2();
}else{
   rotate([0,180, 0])
    inversebox1();
}
