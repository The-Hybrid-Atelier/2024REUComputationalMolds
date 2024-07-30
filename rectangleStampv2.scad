// Import and extrude the SVG file
module extruded_svg() {
    translate([5, 45, -15])
    linear_extrude(height = 10, center = false) {
        import("/Users/Potikuncham/Desktop/stampv2.svg", scale=5);
    }
}

// Create the rectangular cube
module rectangular_cube(width, height, depth) {
    translate([0, 0, -10])
    cube([width, height, depth], center = false);
}

// Create the small rectangular prism
module small_rectangular_prism(width, height, depth) {
    translate([-145, -60, -10])
    cube([width, height, depth], center = false);
}

// Main function
module main() {
    // Rectangular cube parameters
    cube_width = 230;
    cube_height = 100;
    cube_depth = 20;

    // Small rectangular prism parameters
    small_prism_width = 60;
    small_prism_height = 50;
    small_prism_depth = 10;

    union() {
        // Place the rectangular cube at the origin
        translate([0, 0, -cube_depth / 2])
        rectangular_cube(cube_width, cube_height, cube_depth);

        // Place the extruded SVG on top of the cube
        translate([0, 0, cube_depth / 2 + 10 / 2])
        extruded_svg();

        // Place the small rectangular prism on the side of the cube
        translate([cube_width, (cube_height - small_prism_height) / 2, -cube_depth / 2])
        small_rectangular_prism(small_prism_width, small_prism_height, small_prism_depth);
    }
}

// Run the main function
main();
