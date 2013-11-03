//dimensions of the 3/8X3/8 inch cylinder magnet
//magR also equals ballbearing radius
magR=9.525/2;
magH=9.525+0.2;
cupR=9.525/2-0.1;

//the ARM
armH=272;
armR=6;

//distance between the cylinder magnet and the ball bearing
magBBsep=-0.05;

//percentages of the ball in the socket
percent=35;

cupZ=(0.5-percent/100)*magR*2;

//rotate([90,0,0])testpartpress();
//testpartcup();
//rotate([90,0,0])testpartpresscup();

rotate([90,0,0])reinforced_arm();


module reinforced_arm(){
	difference(){
		union(){
			translate([0,0,cupZ])cylinder(r=armR,h=armH-cupZ,$fn=6);
		//reinforcement
			translate([0,0,cupR+magBBsep])reinforcement();
			translate([0,0,armH-cupR-magH-magBBsep])reinforcement();
		}
		translate([0,0,cupR+magBBsep])mag();
		BB();
		translate([0,0,armH-cupR-magH-magBBsep])mag();
		translate([0,0,armH])BB();
	}
}

module arm(){
	
	difference(){
		translate([0,0,cupZ])cylinder(r=armR,h=armH-cupZ,$fn=6);
		translate([0,0,cupR+magBBsep])mag();
		BB();
		translate([0,0,armH-cupR-magH-magBBsep])mag();
		translate([0,0,armH])BB();
	}
}

module mag(){
	hull(){
		cylinder(r=magR,h=magH,$fn=70);
		translate([0,5,0])cylinder(r=magR-1.5,h=magH,$fn=30);
	}
//a hole to poke out the magnet so that you don't have to break the arm every gosh darn time
	translate([0,500,magH/2])rotate([90,0,0])cylinder(r=1.2, h=1000);
}

module BB(){
	sphere(r=cupR,$fn=100);
}

module reinforcement(){
	difference(){
		translate([0,0,-1.5/2])cylinder(r=armR+1,h=magH+1.5,$fn=6);
	//use those reference traingles and this makes sense! the hexagon, point to point is armR*2	
		translate([0,-100/2-(sqrt(3)/2)*(armR),100/50])cube([100,100,100], center=true);
	}
}

module testpartcup(){
	difference(){
		arm();
		translate([0,0,500+cupR+magBBsep])cube([100,100,1000], center=true);
	}
}

module testpartpress(){
	difference(){
		arm();
		translate([0,0,150+cupR+magBBsep+magH+2])cube([100,100,300], center=true);
		translate([0,0,-50+cupR+magBBsep-1])cube([100,100,100], center=true);
	}
}

module testpartpresscup(){
	difference(){
		arm();
		translate([0,0,500+cupR+magBBsep+magH+2])cube([100,100,1000], center=true);
	}
}

