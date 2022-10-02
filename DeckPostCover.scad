// This is a complete rewrite.  This time, going for rounded edges!
// This may not be right!  Does the minkowki make it bigger by 2*minkValue(), or 1x?
// My measurements are in mm
minkValue=3;  // Diameter of sphere that will be used for minkowski() rounded edges
Outer=109;  // intended outside dimension
SmallOuter=Outer-(minkValue*2);  // slightly smaller dimensions, where minkowski() will be applied
Height=22.4;
SmallHeight = Height-(minkValue*2);  // The height we'll draw the outer shell, minus effect of minkowski()
CenterSquare=52.22;
CenterSquareHeight=Height;
WallThickness=3.0;
InternalVoid=Outer-WallThickness;
InternalVoidHeight=Height-WallThickness;

module outerShell(){
    translate([0,0,minkValue]) // raise it back to the origin plane, by 1 mink
    difference() {  // subtract the left-hand-side of this rectangle
        minkowski() {  // the minkowski() increases overall dimensions by 2*minkValue
            linear_extrude(height=SmallHeight) 
            square([SmallOuter,SmallOuter], center=true);
            sphere(minkValue);
        };
        translate([Outer/2,0,-minkValue]) 
        linear_extrude(height=Height) 
        square([Outer,Outer+minkValue], center=true); // A slightly larger square
    }
}
module centerPost() {
                // Post, centered
                linear_extrude(height=CenterSquareHeight)
                square(CenterSquare, center=true);
}
module innerHollow() {
    // The inside is hollow
        translate([0,0,(minkValue)]) // raise it back to the origin plane, after mink()
    minkowski() {
        linear_extrude(height=(InternalVoidHeight-(minkValue*2)+0.15)) //bug here!
        square((InternalVoid-(minkValue*2)), center=true);
        sphere(minkValue);
    }
}
// This is just a triangular prism
// I'm going by feel, on this one!
// It would fit in a rectangle with these dimensions:
dogEarX=14; // These values should be calculated from Outer (?)
dogEarY=18;
dogEarYPos=((CenterSquare/2 + ((Outer)/2-CenterSquare/2)/2)-WallThickness/2); // Center of arm
module dogEar() {
    linear_extrude(height=WallThickness) 
    polygon([[0,0], [dogEarX,-(dogEarY/2)], [dogEarX,(dogEarY/2)]]); // It's a triangle
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
            translate([-dogEarStrength, dogEarYPos, (Height-WallThickness-0.2)])
            dogEar(); // add the dogEar, in the right place
        }
        // subtract the dogEar, in the right place, bigger by "clearance"!
        resize([(dogEarX+clearance),(dogEarY+clearance)])
        translate([dogEarStrength, -dogEarYPos, (Height-WallThickness)])
        rotate([0,0,180])    
        dogEar();  
    }
