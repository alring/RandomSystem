//
// ElkinsEngine
//
// $Id: ElkinsEngine.m,v 1.3 2004/05/04 14:23:45 gregor Exp $
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


#include "ElkinsEngine.h"
#include <sys/time.h>
#include <stdio.h>


//
// Constants:
//
// See the journal article referenced in the header file.
//

#define M1	32771
#define M2	32779
#define M3	32783
#define F1	179
#define F2	183
#define F3	182

#define RANGE	32768

//#define RANGE	65536
#define MAXNUM	(RANGE - 1)


@implementation ElkinsEngine


//
// unit
//
// The ElkinsEngine, as defined in the article only uses 15 of the 16 bits
// in an unsigned short. We want full bytes of random bits, so we must
// throw away the partial byte.
//

+ (ulong)unit
{
    return 30;
}


//
// init
//

- init
{
    [super init];
    [self newSeeds];
    
    return self;
}


//
// initSeeds:::
//

- initSeeds:(ushort)s1
  :(ushort)s2
  :(ushort)s3
{
    [super init];
    [self setSeeds:s1 :s2 :s3];

    return self;
}


//
// newSeeds
//

- newSeeds
{
    struct timeval theTime;		// gettimeofday return structure
//    ushort foo;
    
    gettimeofday(&theTime, 0);		// Get the time of day in seconds and microseconds
    h1 = theTime.tv_usec % RANGE;	// Set seed 1 by microseconds past second
    gettimeofday(&theTime, 0);		// Get the time of day in seconds and microseconds
    h2 = theTime.tv_usec % RANGE;	// Set seed 2 by microseconds past second
    gettimeofday(&theTime, 0);		// Get the time of day in seconds and microseconds
    h3 = theTime.tv_usec % RANGE;	// Set seed 3 by microseconds past second

//    printf("ElkinsEngine: Seeds set to: %d %d %d\n", (long)h1, (long)h2, (long)h3);

//    [self makeRandom:(char *)(&foo)];

    return self;	
}


//
// setSeeds:::
//

- setSeeds:(ushort) s1 :(ushort) s2 :(ushort) s3
{
//    ushort	foo;
    
    h1 = s1;				// Set the seeds to the values given
    h2 = s2;
    h3 = s3;
    
//    [self makeRandom:(char *)(&foo)];
    
    return self;
}


//
// getSeeds:::
//

- getSeeds:(ushort *)s1 :(ushort *)s2 :(ushort *)s3
{
    if((s1 == NULL) || (s2 == NULL) || (s3 == NULL))
	return nil;

    *s1 = h1;
    *s2 = h2;
    *s3 = h3;

    return self;
}


//
// makeRandom:
//
// See the Source article for the explanations of these constants:
//

- makeRandom:(uchar *)storage
{
    ushort	temp;
    int		i;
    ushort	*out = (ushort *)storage;
    
    do{
	h1 = (F1 * h1) % M1;					// Update the sections
	h2 = (F2 * h2) % M2;
	h3 = (F2 * h3) % M3;
    } while ((h1 > MAXNUM) || (h2 > MAXNUM) || (h3 > MAXNUM));	// If a section is out of range,
    
    temp = ((h1 + h2 + h3) % RANGE);
    
    for(i = 0; i < 15; i++) {
	do{
	    h1 = (F1 * h1) % M1;
	    h2 = (F2 * h2) % M2;
	    h3 = (F2 * h3) % M3;
	} while ((h1 > MAXNUM) || (h2 > MAXNUM) || (h3 > MAXNUM));
        
	//
	// Save the value, and grab a bit from temp;
	//
	
	out[i] = (ushort)((h1 + h2 + h3) % RANGE) + ((temp & 0x0001) ? 0x8000 : 0x0000);
        temp = temp >> 1;
    }
    
    
    
    return self;
}

//
// read:
//

- read:(TypedStream *)stream
{
    int		t1;			// Stuff h's into ints for temporary.
    int		t2;
    int		t3;
    
    [super read:stream];
    
    objc_read_types(stream, "iii", &t1, &t2, &t3);
    
    h1 = (ushort)t1;
    h2 = (ushort)t2;
    h3 = (ushort)t3;
    
    return self;
}


//
// write:
//

- write:(TypedStream *)stream
{
    int		t1 = (int)h1;		// Stuff h's into ints for temporary.
    int		t2 = (int)h2;
    int		t3 = (int)h3;
    
    [super write:stream];
    
    objc_write_types(stream, "iii", &t1, &t2, &t3);

    return self;
}

@end


//
// End of file.
//
