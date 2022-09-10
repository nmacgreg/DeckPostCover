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
module dogEar() {
    polygon([[0,0], [15,-13], [15,13]]);
}
union() {
    difference() {
        difference() {
            // Outer shell
            translate([-Quarter,0]) 
            linear_extrude(height=Height) 
            square([Half,Outer], center=true);
            // Hole, center top
            linear_extrude(height=CenterSquareHeight)
                square(CenterSquare, center=true);
        }
        // The inside is hollow
        linear_extrude(height=19.69)
            square(InternalVoid, center=true);
    };      
    translate ([-4, (Outer/2 - 13), (Height-WallThickness)])
    linear_extrude(height=WallThickness) dogEar();
    // polygon([[0,0], [15,-13], [15,13]]);
}
