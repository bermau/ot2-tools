


WIDTH_X = 127.5 ;
DEPTH_Y =  85.5 ;

LOW_Z = 7.3 ;

HEIGHT_Z = 43 +  LOW_Z ; 
WALL_EPP = 2; 
eps = 0.5; 


module base(){
    cube([WIDTH_X, DEPTH_Y, LOW_Z]);
    
} 


win_path = [[0,0,]  , [-7, 0], [-7, 20],[-7 , 30], [-7+7, 45] ];


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


color("yellow", 0.2) translate([-WIDTH_X/2,-DEPTH_Y/2,0,]) base();

translate([-WIDTH_X/2,-DEPTH_Y/2,0,]) front_wall();
translate([WIDTH_X/2,(DEPTH_Y/2)-WALL_EPP,0]) mirror([1,0,0]) front_wall();

translate([-WIDTH_X/2,-DEPTH_Y/2,0,]) side_wall();
%translate([(WIDTH_X/2)-WALL_EPP,(DEPTH_Y/2),0,])mirror([0,1,0]) side_wall();
