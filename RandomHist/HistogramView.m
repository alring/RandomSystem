//
// HistogramView
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


#import "HistogramView.h"
#import "Random.h"
#import "ElkinsEngine.h"
#import <appkit/Button.h>
#import <dpsclient/wraps.h>	/* for PSxxx functions */
#import <stdlib.h>
#import <math.h>


#define	RANGEFROM	0.0
#define RANGETO		1.0	
#define NUMBINS		800
#define SCALE		1
#define SCALEBY		2


@implementation HistogramView


//
// initFrame:
//

- initFrame:(const NXRect *)frameRect
{
    return [self initFrame:frameRect scale:SCALE numBins:NUMBINS];
}


//
// initFrame:scale:numBins:
//

- initFrame:(const NXRect *)frameRect scale:(int)aScale numBins:(int)aNumBins
{
    [super initFrame:frameRect];
    
    randGen = [[Random alloc] initEngineInstance:[[ElkinsEngine alloc] init]];
    
    scaleInval = YES;
    scale = aScale;
    
    numBins = aNumBins;
    
    binFlags = NULL;
    bins = NULL;
    binRects = NULL;
    
    [self allocBins];
    
    return self;
}


//
// free
//

- free
{
    free(binFlags);
    free(bins);
    free(binRects);
    
    return [super free];
}


//
// allocBins
//

- allocBins
{
    int		i;
    
    if(binFlags != NULL) free(binFlags);
    if(bins != NULL) free(bins);
    if(binRects != NULL) free(binRects);
    
    binFlags = (BOOL *)malloc(numBins * sizeof(BOOL));
    bins = (int *)malloc(numBins * sizeof(int));
    binRects = (NXRect *)malloc(numBins * sizeof(NXRect));
    
    binsLeft = 0.0;
    binsBottom = 0.0;
    binWidth = bounds.size.width / numBins;
    binHeightIncrement = bounds.size.height / scale;
    
    for(i = 0; i < numBins; i++) {
        binFlags[i] = NO;
	bins[i] = 0;
	
	binRects[i].origin.x = binsLeft + i * binWidth;
	binRects[i].origin.y = binsBottom;
	binRects[i].size.width = binWidth;
	binRects[i].size.height = 0.0;
    }
    
    return self;
}


//
// start:
//

- start:sender
{
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
        [self addPoint:[randGen percent]];
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
    
    scaleInval = YES;
    scale = SCALE;
    
    numBins = NUMBINS;
    
    [self allocBins];
        
    [self display];
    
    return self;
}


//
// rescaleTo:
//

- rescaleTo:(int)newScale
{
    int		i;
    
    if((newScale < 1) || (newScale >= MAXINT)) {
        [self clear:self];
	return self;
    }
    
    scale = newScale;
    
    binHeightIncrement = bounds.size.height / scale;
    
    for(i = 0; i < numBins; i++) {
        binRects[i].size.height = binHeightIncrement * bins[i];
    }
    
    scaleInval = YES;
    
    return self;
}


//
// addPoint:
//

- addPoint:(double)x
{
    int		binNum;
    
    if((x < 0.0) || (x >= 1.0))
	return self;
    
    binNum = floor(numBins * x);
    
    binFlags[binNum] = YES;
    bins[binNum]++;
    
    if(bins[binNum] > scale)
    	[self rescaleTo:(scale * SCALEBY)];
    else
    	binRects[binNum].size.height += binHeightIncrement;
    
    [self display];
    
    return self;
}


//
// add:points:
//

- add:(int)num points:(double *)array
{
    return self;
}


//
// takeScaleFrom:
//

- takeScaleFrom:aControl
{
    return self;
}


//
// takeNumBarsFrom:
//

- takeNumBarsFrom:aControl
{
    return self;
}


//
// drawSelf::
//

- drawSelf:(const NXRect *)rects :(int)rectCount
{
    int		i;
    
    //
    // Redraw the scale, if necessary:
    //
    
    if(scaleInval) {
	PSsetgray(NX_WHITE);
	NXRectFill(&bounds);
	PSsetgray(NX_BLACK);
	NXFrameRect(&bounds);
	
	//
	// Draw the scale:
	//
    }
    
    //
    // Redraw the bins, as necessary:
    //
    
    for(i = 0; i < numBins; i++) {
    	if(binFlags[i] || scaleInval) {
	    PSsetgray(NX_BLACK);
	    NXRectFill(&binRects[i]);
	    
	    binFlags[i] = NO;
	}
    }
    
    //
    // Cleanup and return:
    //
    
    scaleInval = NO;
    
    return self;
}



@end


//
// End of file.
//
