$fn=35;
module thingie(){


difference(){
    cylinder(3,16/2,16/2);
cylinder(30,11/2,11/2);
    translate([-20,-13.5,0])#cube([40,10,10]);
}


translate([0,17,0])

difference(){
    union(){
    
cylinder(20,7,7);
    translate([-5,5-16,0])
cube([10,10,3]);
    
}
cylinder(20,3.4,4);
}
};

translate([20,0,-5-3]) thingie();

difference(){
    translate([-10,-10,-3])cube([20,40,6.9]);
minkowski() {
scale([1,1,2])thingie();
    	sphere(r = 1);
}
}
translate([-4,0,-5-3])
cylinder(5,6.3/2,6.3/2);

translate([-4+9.02,0,-5-3])
cylinder(5,6.3/2,6.3/2);


translate([0,9.02,0]){
translate([-4+9.02,0,-5-3])
cylinder(5,6.3/2,6.3/2);
translate([-4,0,-5-3])
cylinder(5,6.3/2,6.3/2);
}
