//
// R250Engine
//
// $Id: R250Engine.m,v 1.3 2004/05/04 14:23:45 gregor Exp $
//
// Copyright (C) 1992-2004 Gregor N. Purdy. All rights reserved.
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


#include "R250Engine.h"
#include <stdlib.h>
#include <stdio.h>


@implementation R250Engine


//
// unit
//

+ (int)unit
{
    return 4;					// r250 creates 4 byte chunks.
}


//
// init
//

#define SPREAD(num)	(11 * num + 3)

- init
{
    unsigned long	mask, diag;
    int			i;
    
    //
    // Insert pseudo-random numbers into the buffer:
    //
    
    for(i = 0; i < 250; i++) {			// Scan through entire array.
        buffer[i] = rand();			//   Put a random number at each location.
	if(rand() > (RAND_MAX / 2))		//   50% Chance that
	    buffer[i] |= 0x80000000;		//     we'll OR in the high bit. 
    }
    
    //
    // Guarantee the existance of some specific patterns:
    //
    
    diag = 0x80000000;
    mask = 0xffffffff;

    for(i = SPREAD(0); i <= SPREAD(31); i = SPREAD(i)) {
	buffer[i] = (buffer[i] & mask) | diag;	//   Turn diagonal on and left bits off.
	mask >>= 1;				//   Shift mask to new value.
	diag >>= 1;				//   Shift diag to new value.
    }
    
    return self;
}


//
// makeRandom:
//

- makeRandom:(uchar *)storage;
{
    buffer[index] = buffer[index] ^ buffer[(index + 103) % 250];	// Make the next number.
    index = (index + 1) % 250;						// Increment our index.
    
//    printf("R250Engine: Returning unsigned long %ul.\n", buffer[index]);
    
    *((unsigned long *)storage) = buffer[index];			// Return it to sender.
    
    return self;
}

//
// read:
//

- read:(TypedStream *)stream
{
    int		i;
    
    [super write:stream];
    
    objc_read_types(stream, "i", &index);
    
    for(i = 0; i < 250; i++) {
    	objc_read_types(stream, "i", &(buffer[i]));
    }
    
    return self;
}


//
// write:
//

- write:(TypedStream *)stream
{
    int		i;
    
    [super write:stream];
    
    objc_write_types(stream, "i", &index);
    
    for(i = 0; i < 250; i++) {
    	objc_write_types(stream, "i", &(buffer[i]));
    }
    
    return self;
}


@end


//
// End of file.
//
