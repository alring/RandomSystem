//
// PointsView
//
// Copyright (C) 1992-2004 Gregor N. Purdy. All rights reserved.
//
// This file is part of Random.
//
// Random is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// Random is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Random; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//


#import "PointsView.h"
#import "Random.h"
#import "ElkinsEngine.h"
#import <appkit/Button.h>
#import <dpsclient/wraps.h>	/* for PSxxx functions */


@implementation PointsView


//
// init
//

- initFrame:(const NXRect *)frameRect
{
    [super initFrame:frameRect];
    
    randGen = [[Random alloc] initEngineInstance:[[ElkinsEngine alloc] init]];
    initial = YES;
    plottingPoints = YES;
    
    return self;
}


//
// start:
//

- start:sender
{
    int i;
    
    [startButton setEnabled:NO];
    [stopButton setEnabled:YES];
    
    //
    // Set up modal session:
    //
    
    [NXApp beginModalSession:&mySession for:[self window]];
    
    //
    // Run modal session:
    //
    
    while([NXApp runModalSession:&mySession] != NX_RUNSTOPPED) {
        if(plottingPoints) {
	    for(i = 0; i < 25; i++)
		[self plotX:[randGen percent] y:[randGen percent]];
	    [self update];
	}
	else {
	    for(i = 0; i < 10; i++)
		[self plotLine:[randGen percent] :[randGen percent]
			:[randGen percent] :[randGen percent]];
	    [self update];
	}
    }
    
    return self;
}


//
// stop:
//

- stop:sender
{
    [stopButton setEnabled:NO];
    [startButton setEnabled:YES];
    
    [NXApp stopModal];
    
    return self;
}


//
// clear:
//

- clear:sender
{
    [self lockFocus];
    
    PSsetgray(NX_WHITE);
    NXRectFill(&bounds);
    PSsetgray(NX_BLACK);
    NXFrameRect(&bounds);
    
    [self unlockFocus];
    
    [self update];
    
    return self;
}


//
// plotPoints:
//

- plotPoints:sender
{
    plottingPoints = YES;
    
    return self;
}


//
// plotLines:
//

- plotLines:sender
{
    plottingPoints = NO;
    
    return self;
}


//
// plotX:y:
//

- plotX:(double)x y:(double)y
{
//    NXRect	myRect;
    
//    myRect.origin.x = bounds.origin.x + x * bounds.size.width;
//    myRect.origin.y = bounds.origin.y + y * bounds.size.height;
//    myRect.size.width = 1.0;
//    myRect.size.height = 1.0;
    
    [self lockFocus];
    
    PSsetgray(NX_BLACK);
    PSsetlinewidth(0.5);
    PSmoveto(bounds.origin.x + x * bounds.size.width, bounds.origin.y + y * bounds.size.height);
    PSrlineto(0.0, 0.0);
    PSstroke();
    
    [self unlockFocus];
    
    return self;
}


//
// plotLine::::
//

- plotLine:(double)x1 :(double)y1 :(double)x2 :(double)y2
{
    [self lockFocus];
    
    PSsetgray(NX_BLACK);
    PSsetlinewidth(1.0);
    PSmoveto(bounds.origin.x + x1 * bounds.size.width, bounds.origin.y + y1 * bounds.size.height);
    PSlineto(bounds.origin.x + x2 * bounds.size.width, bounds.origin.y + y2 * bounds.size.height);
    PSstroke();
    
    [self unlockFocus];
    
    return self;
    return self;
}


//
// drawSelf::
//

- drawSelf:(const NXRect *)rects :(int)rectCount
{
    if(initial) {
	PSsetgray(NX_WHITE);
	NXRectFill(&bounds);
	initial = NO;
    }
    
    PSsetgray(NX_BLACK);
    NXFrameRect(&bounds);
    
    return self;
}



@end


//
// End of file.
//
