// My measurements are in mm
Outer=109;
Height=22.4;
CenterSquare=52.22;
CenterSquareHeight=Height+0.2; //slightly taller
WallThickness=2.6;
InternalVoid=Outer-WallThickness;
InternalVoidHeight=Height-WallThickness;
difference() {
    difference() {
        // Outer shell
        linear_extrude(height = Height)
            square(Outer, center = true);
        // Hole, center top
        linear_extrude(height=CenterSquareHeight)
            square(CenterSquare, center=true);
    }
    // The inside is hollow
    linear_extrude(height=19.69)
        square(InternalVoid, center=true);
}         

