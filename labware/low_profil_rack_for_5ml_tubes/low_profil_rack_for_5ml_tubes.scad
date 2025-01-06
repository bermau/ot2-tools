// J'ai créé ce portoir lors de l'étude resprotect


WIDTH_X = 127.76 ;
DEPTH_Y =  85.48 ;

LOW_Z = 7.3 ;   // Epaisseur du bas du rack
EPP_BAS = 3 ; // épaisseur du  pour calage des tubes en bas 

HEIGHT_Z = 43 +  LOW_Z ; 
WALL_EPP = 2; 
eps = 0.5; 

// Adaptation pour des tubes Copan de 3 ml, commandés pour l'enquête.
// Mesurent environ 80 mm de long. 
// avec 2 étiquettes collées l'une sur l'autre.
D_TUBES = 14.8 ; 

DELTA_EMBOITEMENT = 0.5 ;

module base(){
    cube([WIDTH_X, DEPTH_Y, LOW_Z]);
} 


win_path = [[0,0,]  , [-7, 0], [-7, 20],[-7 , 35], [-7+7, 48] ];


module half_win(){
    translate([0,WALL_EPP,0]) 
    rotate([90,0 ,0])
     translate([0,0,-eps]) 
       linear_extrude(WALL_EPP + 2*eps) 
         polygon(win_path);
}

module trou(){
    union(){   
       half_win();
       translate([-eps,0,0])
        mirror([1,0,0]) half_win();
    }
}


module front_wall(){
    difference(){
    cube([WIDTH_X, WALL_EPP,  HEIGHT_Z ]);
        for ( i = [10:20:120]) {
        translate([i,0,0]) trou();
        }
    }
}


module side_wall(){
    difference(){
    cube([ WALL_EPP, DEPTH_Y   ,   HEIGHT_Z ]);
      for ( i = [0:20:70])  {  
         translate([WALL_EPP, 14 +i, 0]) rotate([0,0,90]) trou();
         }
          }
}


module bottom(){
union(){
    color("yellow", 0.2) translate([-WIDTH_X/2,-DEPTH_Y/2,0,]) base();

    translate([-WIDTH_X/2,-DEPTH_Y/2,0,]) front_wall();
    translate([WIDTH_X/2,(DEPTH_Y/2)-WALL_EPP,0]) mirror([1,0,0]) front_wall();

    translate([-WIDTH_X/2,-DEPTH_Y/2,0,]) side_wall();
    translate([(WIDTH_X/2)-WALL_EPP,(DEPTH_Y/2),0,])mirror([0,1,0]) side_wall();
    }
    }
    
NB_COL = 5; 
NB_ROW = 3; 
SPC_COL = 25 ; 
SPC_ROW = 25; 
    
module trou_toit(){
    translate([(WIDTH_X - (NB_COL-1) * SPC_COL)/2, (DEPTH_Y - (NB_ROW-1) * SPC_ROW)/2, -5]) 
    for ( i = [0:SPC_COL:(NB_COL-1)*SPC_COL]) 
        for (j= [0:SPC_ROW:SPC_ROW*2]) {
                translate([i, j, 0])cylinder(h=15, d=D_TUBES, $fn=60);
}
}

module toit(){
    difference(){
        union(){
            // plateau avec décalage
            // plateau avec coupure du coin.
            difference()
            {
            cube([WIDTH_X, DEPTH_Y, 1]);
            translate([-2, DEPTH_Y-7, -1])
                rotate([0,0,45]) cube([20, 20, 5]);
        }
        
            translate([WALL_EPP + (DELTA_EMBOITEMENT/2), WALL_EPP + (DELTA_EMBOITEMENT/2), -2 +eps])
                cube([WIDTH_X-DELTA_EMBOITEMENT - WALL_EPP*2, 
                      DEPTH_Y - DELTA_EMBOITEMENT - WALL_EPP*2, 
                      2]);
            
            translate([WALL_EPP + (DELTA_EMBOITEMENT/2), WALL_EPP + (DELTA_EMBOITEMENT/2), -2 -1 +0.01 ])
             // ajout d'un liseret pour augmenter la stabilité de l'emboîtement. 
            color("red") difference(){
               // color("yellow", 0.5
                LARGEUR_LISERET = 4;
                cube([WIDTH_X-DELTA_EMBOITEMENT - WALL_EPP*2, 
                      DEPTH_Y - DELTA_EMBOITEMENT - WALL_EPP*2, 2]);
                
                translate([LARGEUR_LISERET,LARGEUR_LISERET,-1])
                cube([WIDTH_X-DELTA_EMBOITEMENT - (WALL_EPP+LARGEUR_LISERET)* 2 , DEPTH_Y - DELTA_EMBOITEMENT - (WALL_EPP+LARGEUR_LISERET)* 2, 4]);
                }
        }
    // trous    
    trou_toit();

    }
}

module trou_bas(){
    translate([(WIDTH_X - (NB_COL-1) * SPC_COL)/2, (DEPTH_Y - (NB_ROW-1) * SPC_ROW)/2, -5]) 
    for ( i = [0:SPC_COL:(NB_COL-1)*SPC_COL]) 
        for (j= [0:SPC_ROW:SPC_ROW*2]) {
                translate([i, j, 0])cylinder(h=15, d=D_TUBES , $fn=60);
        }
}
module support_bas(){
        difference(){
        union(){
            cube([WIDTH_X, DEPTH_Y, EPP_BAS]);
//            translate([WALL_EPP, WALL_EPP, -2+eps])
//                cube([WIDTH_X - WALL_EPP*2, DEPTH_Y- WALL_EPP*2, 2]);
        }
    trou_bas();
    }
}


translate([WIDTH_X/2, DEPTH_Y/2])
    bottom();


//translate([0,0,60])
//rotate([0,0,0])
//    toit();

color("red", 0.2) {
    translate([0,0,LOW_Z]) support_bas();
}