//
// Gaussian
//
// $Id: Gaussian.m,v 1.2 2004/05/04 14:09:39 gregor Exp $
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


#include "Gaussian.h"
#include <math.h>
#include <stdio.h>


@implementation Gaussian


//
// init
//

- initEngineInstance:anObject
{
    [super initEngineInstance:anObject];		
    
    iset = 0;				// No saved gaussian yet.
    gset = 0.0;
    
    gscale = 1.0;
    gorigin = 0.0;

    return self;
}


//
// gScale
//

- (double)gScale
{
    return gscale;
}


//
// setGScale:
//

- setGScale:(double)aScale
{
    gscale = aScale;
    
    return self;
}


//
// gOrigin
//

- (double)gOrigin
{
    return gorigin;
}


//
// setGOrigin:
//

- setGOrigin:(double)anOrigin
{
    gorigin = anOrigin;
    
    return self;
}


//
// gaussian
//

- (double)gaussian
{
    double		fac, r, temp;
    volatile double	v1, v2;			// Prevent compiler warning about un-init.
    
    if(iset == 0) {				// If none stored, calculate a pair.
        do {					// Find a pair which are inside unit circle.
	    v1 = 2.0 * [self percent] - 1.0;
	    v2 = 2.0 * [self percent] - 1.0;
	    r = (v1 * v1) + (v2 * v2);
	} while((r >= 1.0) || (r == 0.0));
	
	fac = sqrt(-2.0 * log(r) / r);		// Do Box-Muller transformation.
	gset = v1 * fac;
	iset = 1;
	
	temp = v2 * fac;			// Return one of the pair.
	
//	printf("Gaussian: New value = %f, new stored value = %f\n", temp, gset);
    }
    else {					// Otherwise return stored one.
        iset = 0;
	temp = gset;
    }
    
    return ((temp * gscale) + gorigin);		// Modify the variable.
}


//
// read:
//

- read:(TypedStream *)stream
{
    [super read:stream];
    
    objc_read_types(stream, "iddd", &iset, &gset, &gscale, &gorigin);
    
    return self;
}


//
// write:
//

- write:(TypedStream *)stream
{
    [super write:stream];
    
    objc_write_types(stream, "iddd", &iset, &gset, &gscale, &gorigin);

    return self;
}


@end


//
// End of file.
//
