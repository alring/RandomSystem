//
// StandardEngine
//
// $Id: StandardEngine.m,v 1.2 2004/05/04 14:09:39 gregor Exp $
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


#include "StandardEngine.h"
#include <sys/time.h>
#include <stdlib.h>


@implementation StandardEngine


//
// unit
//
// The standard random call returns 31 pseudo-random bits in a 32-bit signed long.
// We want every byte in our buffer to have 8 pseudo-random bits. So, we generate
// one word of 31 random bits, and then generate 31 more words (each with 31
// pseudo-random bits), and to each we add a bit from the first to bring the total
// in each word to 32. This means we must create a total of 31 words for each call
// to makeRandom, so our unit size is 31 * 4, or 124.
//

+ (int)unit
{
    return 124;
}


//
// init
//

- init
{
    struct timeval theTime;
    gettimeofday(&theTime, 0);
    last = theTime.tv_usec;
    srand(last);
    
    return self;
}


//
// makeRandom:
//

- makeRandom:(uchar *)storage;
{
    ulong		temp;
    int			i;
    ulong		*out = (ulong *)storage;
    
    temp = rand();
    
    for(i = 0; i < 31; i++) {
        out[i] = rand() + ((temp & 0x00000001) ? 0x80000000 : 0x00000000);
	temp = temp >> 1;
    }
    
    last = out[30];
    
    
    ((uchar *)storage)[ 0] = (last & 0x000000ff);
    ((uchar *)storage)[ 1] = (last & 0x0000ff00) >> 8;
    ((uchar *)storage)[ 2] = (last & 0x00ff0000) >> 16;

    last = rand();
    
    ((uchar *)storage)[ 3] = (last & 0x000000ff);
    ((uchar *)storage)[ 4] = (last & 0x0000ff00) >> 8;
    ((uchar *)storage)[ 5] = (last & 0x00ff0000) >> 16;

    last = rand();
    
    ((uchar *)storage)[ 6] = (last & 0x000000ff);
    ((uchar *)storage)[ 7] = (last & 0x0000ff00) >> 8;
    ((uchar *)storage)[ 8] = (last & 0x00ff0000) >> 16;

    last = rand();
    
    ((uchar *)storage)[ 9] = (last & 0x000000ff);
    ((uchar *)storage)[10] = (last & 0x0000ff00) >> 8;
    ((uchar *)storage)[11] = (last & 0x00ff0000) >> 16;
    
    return self;
}


//
// read:
//

- read:(TypedStream *)stream
{
    [super write:stream];
    
    objc_read_types(stream, "i", &last);
    srand(last);
    
    return self;
}


//
// write:
//

- write:(TypedStream *)stream
{
    [super write:stream];
    
    objc_write_types(stream, "i", &last);
    
    return self;
}


@end


//
// End of file.
//
