inner_diameter = 55.5;
outer_diameter = 68;
difference(){
    cylinder(d=outer_diameter, h=85, $fn=6);
    cylinder(d=inner_diameter, h=85, $fn=150);
}

battery_holder_diameter = 33;
battery_holder_thickness = 1;
battery_holder_height=10;
battery_holder_offset=30;

gap = (inner_diameter-battery_holder_diameter)/2;

module rotate_about_pt(z, y, pt) {
    translate(pt)
        rotate([0, y, z]) // CHANGE HERE
            translate(-pt)
                children();   
}

module connector(){
    linear_extrude(height = battery_holder_height) {
        # translate([battery_holder_diameter/2,0,0])
        polygon(points = [ [0, 0],
                        [gap, 0],
                        [gap, battery_holder_thickness],
                        [0, battery_holder_thickness]]
        );
    }
}

translate([0,0,battery_holder_offset]){
    difference(){
        cylinder(d=battery_holder_diameter+(2*battery_holder_thickness), h=battery_holder_height, $fn=150);
        cylinder(d=battery_holder_diameter, h=battery_holder_height, $fn=150);
    }
    connector();
    rotate_about_pt(120,0,[0,0,0])
        connector();
    rotate_about_pt(240,0,[0,0,0])
        connector();
}