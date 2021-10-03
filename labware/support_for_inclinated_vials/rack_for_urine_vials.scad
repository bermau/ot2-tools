X_BOX = 127.76; 
Y_BOX = 85.48; 
R_CORNER = 3.18 ; 

Z_HEIGHT  = 20; 

// UV : Urine Vial
UV_DIA = 35.06 / 2 ;
UV_SP = 0.5; // space to avoid friction 
UV_ANGLE  = 10;  
eps = 0.01 ; 

module vial(){
    cylinder(r=UV_DIA+UV_SP, h = 30, $fn=60);
} ; 


module vial_array(){
    for (i= [0, 1, 2]) for(j= [0, 1]){       
       translate([19 + 41 * i, 19 +2+ j * 43, 5]) 
           rotate([0, UV_ANGLE, 0]) vial();   
    }
} 

module texts(){
    
    for (i= [0, 1, 2]) for(j= [0, 1]){
        mytext= str(chr(66 -j), i+1);
        echo(mytext);
        translate([1+ 41 * i, 35 + j * 43, 19])
        linear_extrude(height = 2) text(mytext,size = 5);
    }        
}

// main
difference(){
    color("yellow", 0.5) #cube([X_BOX, Y_BOX, Z_HEIGHT   ] ); 
    color("blue", 0.8) vial_array();
    
    // Tronquer le coté en haut à gauche
    translate([0,Y_BOX-5, -0.1])
    rotate([0,0,45]) translate([-10,,0]) cube([20, 20, 30]);
    texts();
}

    // texts
    // texts();

