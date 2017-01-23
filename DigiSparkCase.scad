/*
  DigiSparkCase.scad
 
  Author: radiogeek381@gmail.com

  A box that can hold a single DigiStump DigiSpark arduino module.
  It is a clamshell box, with a slot in the bottom for in/out wires
  and a relief in the top for the LED. 
*/ 
/*
Copyright (c) 2016, Matthew H. Reilly (kb1vc)
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

    Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
    Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in
    the documentation and/or other materials provided with the
    distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

// All dimensions are in inches -- scaling to mm is at the end.

$fn=32;

// wall thickness
WallThickness = 0.1;

// dimensions of the INSIDE of the box
InnerX = 1.3;
InnerY = 0.8;
InnerZ = 0.15;


// The lower shell has a key (tab) that sticks up.  How high? 
KeyHeight = 0.1;
// How thick? (this subtracts from the wall thickness.
KeyThickness = 0.05;
// Where does the key end? (how far from each inside edge.)
KeySetback = 0.15;
KeywaySetBack = 0.1;
KeywayThickness = KeyThickness + 0.005; // give a little relief
KeywayDepth =0.6; 

OuterX = InnerX + 2 * WallThickness;
OuterY = InnerY + 2 * WallThickness;
OuterZ = InnerZ + WallThickness;

WireHoleX = 0.05;
WireHoleY = 0.25;
WireHoleOffsetY = OuterY * 0.5;
WireHoleOffsetX = OuterX - (0.1 + WallThickness);

LEDReliefDia = 0.1;
LEDReliefDepth = 0.02; 
LEDOffsetX = OuterX - (0.3 + WallThickness); 
LEDOffsetY = WallThickness + 0.3;


module ClamShellBottom() {
    difference() {
        cube([OuterX, OuterY, OuterZ]);
	translate([WallThickness + KeywaySetBack, WallThickness - KeywayThickness, OuterZ - KeyHeight * 1.1]) {
	    cube([InnerX - 2.5 * KeywaySetBack, InnerY + 2.05 * KeywayThickness, InnerZ]);
        }
	// cut space for keys
	translate([WallThickness - KeywayThickness, WallThickness + KeywaySetBack, OuterZ - KeyHeight * 1.1]) {
	    cube([InnerX + 2.05 * KeywayThickness, InnerY - 2.5 * KeywaySetBack, InnerZ]);
	}
	translate([WallThickness, WallThickness, WallThickness]) {
	    cube([InnerX, InnerY, InnerZ*2]);
	}
	// cut hole for wires
	translate([WireHoleOffsetX, WireHoleOffsetY, -0.01]) {
	    cube([WireHoleX, WireHoleY, 3*WallThickness], center=true);
	}

    }
}

module ClamShellTop() {
    difference() {
        union() {
	    cube([OuterX, OuterY, OuterZ]);
	    translate([WallThickness + KeywaySetBack, WallThickness - KeywayThickness, OuterZ - 0.01]) {
	        cube([InnerX - 2.5 * KeywaySetBack, InnerY + 2.05 * KeywayThickness, KeyHeight]);
            }
	    translate([WallThickness - KeywayThickness, WallThickness + KeywaySetBack, OuterZ - 0.01]) {
	        cube([InnerX + 2.05 * KeywayThickness, InnerY - 2.5 * KeywaySetBack, KeyHeight]);
            }
	}
	translate([WallThickness, WallThickness, WallThickness]) {
	    cube([InnerX, InnerY, InnerZ*2]);
	}
	// cut the blind hole for the LED
	translate([LEDOffsetX, LEDOffsetY, LEDReliefDepth]) {
	    cylinder(d=LEDReliefDia, h=WallThickness*2, center=false);
	}
    }
}


scale([25.4,25.4,25.4]) {
    union()
    {
        color("red") ClamShellBottom();
	translate([OuterX,0,2.5*OuterZ])
	    rotate([0,180,0])
	        color("grey") ClamShellTop();
    }
}
