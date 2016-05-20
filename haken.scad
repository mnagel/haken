d = 5;         // thickness
lendown = 60;  // length of main bar
lentop = 85;   // length of upper bar
radius = 27;   // radius of lower circle
screw=3;       // screw size

bs = d*5;           // backpane width
bsh = lendown*0.9;  // backpane height
bsd = d;            // backpane thickness

buffer = 1;

$fn=40;

// downwards bar
hull() {
	sphere(d);
	translate([lendown, 0,0]) {
		sphere(d);
	}
}

// top bar
translate([lendown, 0,0])
rotate(30,[0,0,1]) {
	hull() {
		sphere(d);
		translate([lentop, 0,0]) {
			sphere(d);
		}
	}
}

// circle bar
translate([0,radius,0])
rotate(90,[0,0,1]) {
	intersection(){
	// full ring
	rotate_extrude(convexity = 10,$fn=40)
	translate([radius, 0, 0])
	circle(r = d);

	// take one half only
	translate([-500, 0, -500])
	cube(1000,1000,1000);
	}

}
// sphere finish for circle bar
translate([0,2*radius,0])
sphere(d);

translate([0,-bsd-d*0.8,-bs/2])
difference() {
	minkowski() {
		cube([bsh,bsd,bs]);
		rotate(-90,[1,0,0])
		sphere(r=screw);
	}
	union() {
        // mounting hole 1 core
		translate([bsh*0.93,-(screw+buffer),bs*0.85])
		rotate(-90,[1,0,0])
		cylinder(bsd + 2*(screw+buffer),r=screw*0.5);

        // mounting hole 1 counterbore
		translate([bsh*0.93,screw,bs*0.85])
		rotate(-90,[1,0,0])
		cylinder(bsd + 2*(screw+buffer),r=screw);

        // mounting hole 2 core
		translate([bsh*0.07,-(screw+buffer),bs*0.15])
		rotate(-90,[1,0,0])
		cylinder(bsd + 2*(screw+buffer),r=screw*0.5);

        // mounting hole2 counterbore
		translate([bsh*0.07,screw,bs*0.15])
		rotate(-90,[1,0,0])
		cylinder(bsd + 2*(screw+buffer),r=screw);
	}
}
