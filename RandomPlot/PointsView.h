//
// PointsView
//
// This is an Objective-C class that is a view that plots points.
//
// History:
//
// 	1992 MAY 04 EDT 19:17:	GNP	Genesis.
//
// Copyright (C) 1992-2004 Gregor N. Purdy. All rights reserved.
//
// $Id: PointsView.h,v 1.2 2004/05/04 14:23:45 gregor Exp $
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


@interface PointsView:View


{
    id			startButton;
    id			stopButton;
    id  		randGen;
    NXModalSession	mySession;
    BOOL		initial;
    BOOL		plottingPoints;
}


- initFrame:(const NXRect *)frameRect;

- start:sender;
- stop:sender;
- clear:sender;
- plotPoints:sender;
- plotLines:sender;

- plotX:(double)x y:(double)y;
- plotLine:(double)x1 :(double)y1 :(double)x2 :(double)y2;

- drawSelf:(const NXRect *)rects :(int)rectCount;


@end


//
// End of file.
//
