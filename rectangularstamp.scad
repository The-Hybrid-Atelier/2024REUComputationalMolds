// Attempt to import SVG file with various settings
linear_extrude(height = 10, center = true){import("/Users/atelier-member/Downloads/121.svg", scale=10);}

translate([8, 32, -5])
    cube([77, 30, 20]);
