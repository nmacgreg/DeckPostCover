// My measurements are in mm
Outer=109;
Height=22.4;
CenterSquare=52.22;
CenterSquareHeight=Height+0.2; //slightly taller
WallThickness=2.6;
InternalVoid=Outer-WallThickness;
InternalVoidHeight=Height-WallThickness;
module outerShell(){
                // Outer shell is 
                translate([-(Outer/4),0]) 
                linear_extrude(height=Height) 
                square([(Outer/2),Outer], center=true);    
}
module centerPost() {
                // Post, centered
                linear_extrude(height=CenterSquareHeight)
                    square(CenterSquare, center=true);
}
module innerHollow() {
                // The inside is hollow
            linear_extrude(height=InternalVoidHeight)
                square(InternalVoid, center=true);
}
// This is just a triangular prism
// I'm going by feel, on this one!
// It would fit in a rectangle with these dimensions:
dogEarX=14; // These values should be calculated from Outer (?)
dogEarY=18;
dogEarYPos=((CenterSquare/2 + (Outer/2-CenterSquare/2)/2)); // Center of arm
module dogEar() {
    linear_extrude(height=WallThickness) 
    polygon([[0,0], [dogEarX,-(dogEarY/2)], [dogEarX,(dogEarY/2)]]);
}
clearance=0.1; // a "fudge-factor" for 3D printing, letting parts fit
dogEarStrength=5; // how deep to bury the dogEars
difference() {
    union() {
        difference() {
            difference() {
                outerShell();
                centerPost();
            }
            innerHollow();
        }      
        translate([-dogEarStrength, dogEarYPos, (Height-WallThickness)])
        dogEar(); // add the dogEar, in the right place
    }   
    resize([(dogEarX+clearance),(dogEarY+clearance)])
    translate([dogEarStrength, -dogEarYPos, (Height-WallThickness)])
    rotate([0,0,180])    
    dogEar();  // subtract the dogEar, in the right place, bigger!
}
