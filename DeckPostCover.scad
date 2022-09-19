// This is a complete rewrite.  This time, going for rounded edges!
// This may not be right!  Does the minkowki make it bigger by 2*minkValue(), or 1x?
// My measurements are in mm
minkValue=3;
Outer=109-minkValue;
Height=22.4-minkValue;
CenterSquare=52.22;
CenterSquareHeight=Height+0.2; //slightly taller
WallThickness=3.0;
InternalVoid=Outer-WallThickness;
InternalVoidHeight=Height-WallThickness;

module outerShell(){
    difference() {
        minkowski() {
            linear_extrude(height=Height-(minkValue)) 
            square([(Outer-(minkValue)),Outer-(minkValue)], center=true);
            sphere(minkValue);
        };
        translate([Outer/2,0,-minkValue])
        linear_extrude(height=Height+minkValue) 
        square([Outer,Outer+minkValue], center=true);
    }
}
module centerPost() {
                // Post, centered
                linear_extrude(height=CenterSquareHeight)
                square(CenterSquare, center=true);
}
module innerHollow() {
                // The inside is hollow
    translate([0,0,-minkValue])
            linear_extrude(height=InternalVoidHeight+minkValue)
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
rotate([0,180,0]) translate([0,0,-(Height)])
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
