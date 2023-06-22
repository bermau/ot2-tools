// a Reductor to adapt 4 ml vacuette tube (greiner) to 4 in 1 Opentrons racks

DIA_IN = 13.5 ;
DIA_EXT = 28.5 ; 
DIA_COLERETTE = 28.5 + 4 ; 

Z1 = 8 ; 
Z2 = 2 ; 

$fn= 60 ; 

module  adaptator(){
    difference(){
    union(){
    cylinder(d = DIA_COLERETTE, h = Z2);
    %cylinder(d= DIA_EXT, h = Z1) ; 
    }
    translate([0,0,-1])
    cylinder(d= DIA_IN, h = 50);
    
    #cylinder(h=8, r1= DIA_IN/2 + 2.5, r2= 10/2);
    }
}


adaptator();