$fn=35;
eps = 0.005;

D_TENON = 6.3/2   ; 
BETWEEN_HOLES = 9.02; 
// grip : 
G_HEIGHT = 2 ;
G_DIA = 16; 
G_INT_DIA = 11; 

// a hole, in witch the top part of a p1000 tip is glued
D_TOP = 9; //  8.76
D_BOTTOM = 7.0 ; 



// la pince
module gripper(){

    // gripp. Ce qui tient le tube : un cylindre évidé et tranché
    difference(){
        cylinder(h= G_HEIGHT, d = G_DIA);        
        
        translate ([0,0,-eps]) cylinder(30, d= 11, $fn = 60);
        translate([-20,-13.5,-eps]) cube([40, 10, 10]);
    }


    translate([0,17,0])
        difference(){
             union(){   
                cylinder(20,7,7);
                    translate([-5,5-16,0])
                 // Intermediate section link bethween gripp and cone adapter
                cube([10,10,G_HEIGHT]);
             }
             // cone adapter
             translate([0,0,-eps])cylinder(20 + 2*eps, d1= D_BOTTOM, d2= D_TOP);
        }   
};

translate([25,0,0]) gripper();

//difference(){

//    translate([-10,-10,-3])cube([20,40,6.9]);
//minkowski() {
//scale([1,1,2])thingie();
 //   	sphere(r = 1);
//}
//}



for (i = [0, 1])
    for (j = [0, 1])
        translate([i * BETWEEN_HOLES, j * BETWEEN_HOLES, 0])
            cylinder(5, D_TENON, D_TENON);

