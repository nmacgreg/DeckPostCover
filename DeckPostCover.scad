// My measurements are in mm
Outer=109;
Half=Outer/2;
Quarter=Half/2;
Height=22.4;
CenterSquare=52.22;
CenterSquareHeight=Height+0.2; //slightly taller
WallThickness=2.6;
InternalVoid=Outer-WallThickness;
InternalVoidHeight=Height-WallThickness;
module outerShell(){
                // Outer shell
                translate([-Quarter,0]) 
                linear_extrude(height=Height) 
                square([Half,Outer], center=true);    
}
module centerHole() {
                // Hole, center top
                linear_extrude(height=CenterSquareHeight)
                    square(CenterSquare, center=true);
}
module innerHollow() {
                // The inside is hollow
            linear_extrude(height=InternalVoidHeight)
                square(InternalVoid, center=true);
}
// This is just a triangle 
module dogEar() {
    linear_extrude(height=WallThickness) 
    polygon([[0,0], [14,-9], [14,9]]); // by guess and by gosh
}
difference() {
    union() {
        difference() {
            difference() {
                outerShell();
                centerHole();
            }
            innerHollow();
        };      
        translate([-4, (Outer/2 - 14), (Height-WallThickness)])
        dogEar();
    }   
    translate([3.9, (-(Outer/2 - 14)), (Height-WallThickness)])
    rotate([0,0,180])    
    dogEar();
}