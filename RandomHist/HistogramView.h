//
// HistogramView
//
// This is an Objective-C class that is a view that plots a histogram.
//
// History:
//
// 	1992 MAY 12 EDT 17:25:	GNP	Genesis.
//
// Copyright (C) 1992-2004 Gregor N. Purdy. All rights reserved.
//
// $Id: HistogramView.h,v 1.2 2004/05/04 14:23:45 gregor Exp $
//
// This file is part of RandomSystem.
//
// RandomSystem is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// RandomSystem is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with RandomSystem; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//


#import <appkit/View.h>
#import <appkit/Application.h>
#import <appkit/Control.h>


@interface HistogramView:View


{
    id			startButton;
    id			stopButton;
    
    id  		randGen;
    NXModalSession	mySession;
    
    BOOL		scaleInval;
    int			scale;
    
    double		binsLeft;
    double		binsBottom;
    double		binWidth;
    double		binHeightIncrement;
    
    int			numBins;
    BOOL		*binFlags;
    int			*bins;
    NXRect		*binRects;
}


- initFrame:(const NXRect *)frameRect;
- initFrame:(const NXRect *)frameRect scale:(int)aScale numBins:(int)aNumBins;
- free;

- allocBins;

- start:sender;
- stop:sender;
- clear:sender;

- rescaleTo:(int)newScale;

- addPoint:(double)x;
- add:(int)num points:(double *)array;

- takeScaleFrom:aControl;
- takeNumBarsFrom:aControl;

- drawSelf:(const NXRect *)rects :(int)rectCount;


@end


//
// End of file.
//
