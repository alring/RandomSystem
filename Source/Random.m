//
// Random
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


#import "Random.h"
#import <math.h>
#import <stdlib.h>
#import <stdio.h>


@implementation Random


//
// version
//

+ (int)version
{
    return 3;				// Version 3 = Release 2.0.
}

//
// initEngineClass:
//

- initEngineClass:aClass
{
    return [self initEngineInstance:[[aClass alloc] init]];
}


//
// initEngineInstance:
//
// DESIGNATED INITIALIZER
//

- initEngineInstance:anObject
{
    [super init];

    if(![anObject isKindOf:[RandomEngine class]]) {
        //
	// Can't do that!
	//
    }
    
    engine	= anObject;
    engineClass	= [engine class];
    unit	= [engineClass unit];
    
    bytebuffer	= (uchar *)malloc(unit);
    curbit	= 0;
    curbyte	= 0;
    
    [engine makeRandom:bytebuffer];			// Make some bytes.
    
    bitbuffer = bytebuffer[curbyte];
    curbyte++;
    
    return self;
}


//
// rand
//

- (ulong) rand
{
    ulong	temp = 0;
    char	*ptr = (char *)(&temp);
    ulong	i;
    
    for(i = 0; i < 4; i++) {
        if(curbyte == unit) {				// i.e., bytebuffer empty.
	    [engine makeRandom:bytebuffer];
	    curbyte = 0;
	}
	ptr[i] = bytebuffer[curbyte];
	curbyte++;
    }
    
    return temp;
}


//
// randMax:
//
// This isn't the most conservative algorithm possible. One could rotate bits and/or
// bytes to try to come up with a value in range. However, the added complexity could
// bog down the code even further. Therefore, until somebody proves that being more
// conservative is useful, or a really clever, yet clear, algorithm presents itself,
// this will suffice. Execution should be reasonably fast, and usage of random bits
// and bytes should be reasonably light with this algorithm.
//

- (ulong) randMax:(ulong)max
{
    ulong	ret		= 0;
    ulong	*ptr		= &ret;
    int		i;
    
    if(max == 0) {
        ret = 0;
    }
    else if(max == 1) {						// One bit needed.
	if(curbit == 8) {
	    if(curbyte == unit) {
		[engine makeRandom:bytebuffer];
		curbyte = 0;
	    }
	    bitbuffer = bytebuffer[curbyte];
	    curbyte++;
	    curbit = 0;
	}
    
	ret = (bitbuffer & (0x01 << curbit) != 0);
	curbit++;
    }
    else if(max <= 0x000000ff) {				// One byte needed.
        do {
	    if(curbyte == unit) {
		[engine makeRandom:bytebuffer];
		curbyte = 0;
	    }
	    ret = bytebuffer[curbyte];
	    curbyte++;
	} while (ret > max);
    }
    else if(max <= 0x0000ffff) {				// Two bytes needed.
        do {
	    for(i = 0; i < 2; i++) {
		if(curbyte == unit) {
		    [engine makeRandom:bytebuffer];
		    curbyte = 0;
		}
		ptr[i + 2] = bytebuffer[curbyte];
		curbyte++;
	    }
	} while (ret > max);
    }
    else if(max <= 0x00ffffff) {				// Three bytes needed.
        do {
	    for(i = 0; i < 3; i++) {
		if(curbyte == unit) {
		    [engine makeRandom:bytebuffer];
		    curbyte = 0;
		}
		ptr[i + 1] = bytebuffer[curbyte];
		curbyte++;
	    }
	} while (ret > max);
    } 
    else {							// Four bytes needed.
        do {
	    for(i = 0; i < 4; i++) {
		if(curbyte == unit) {
		    [engine makeRandom:bytebuffer];
		    curbyte = 0;
		}
		ptr[i] = bytebuffer[curbyte];
		curbyte++;
	    }
	} while (ret > max);
    }
    
    return ret;
}


//
// randMin:max:
//

- (ulong)randMin:(ulong)min max:(ulong)max
{
    return min + [self randMax:(max - min)];
}


//
// percent
//
// The information in the following exerpt was used to determine the
// construction of a double-precision number with a value between 0.0 and
// 1.0. It turns out to be easiest to construct one with a mantissa of:
//
// 1.rrrrrrrrrr rrrrrrrrrr rrrrrrrrrr rrrrrrrrrr rrrrrrrrrr rr
// 
// Where "r" stands for a random bit, and where the exponent is 0, i.e.
// E is 1023, or 01111111111. Of course, the sign bit is 0. So, the
// resulting number is:
//
// 00111111 1111rrrr rrrrrrrr rrrrrrrr rrrrrrrr rrrrrrrr rrrrrrrr rrrrrrrr
//
// Nicely enough, there is only 1 byte which is a mix of constant and
// random bits. So, the trick is to generate 7 bytes of random data, and
// then to overlay the constant 1111 into the high-order nibble of the
// 2nd byte. Then, the first byte is just the constant 00111111.
//
// Of course, this is technically platform dependant, which is a no-no,
// but I suppose if we move it to another machine, there may be a function
// to convert from XDR format (which this is) to the local format (one can
// hope), which would save us.
//
// -------------------------------- EXERPT --------------------------------
// 
// Network Working Group                             Sun Microsystems, Inc.
// Request for Comments: 1014                                     June 1987
// 
// 
//                XDR: External Data Representation Standard
// 
// ------------------------------------------------------------------------
// 
// 3.7 Double-precision Floating-point
// 
//    The standard defines the encoding for the double-precision floating-
//    point data type "double" (64 bits or 8 bytes).  The encoding used is
//    the IEEE standard for normalized double-precision floating-point
//    numbers [3].  The standard encodes the following three fields, which
//    describe the double-precision floating-point number:
// 
//       S: The sign of the number.  Values 0 and 1 represent positive and
//          negative, respectively.  One bit.
// 
//       E: The exponent of the number, base 2.  11 bits are devoted to
//          this field.  The exponent is biased by 1023.
// 
//       F: The fractional part of the number's mantissa, base 2.  52 bits
//          are devoted to this field.
// 
//    Therefore, the floating-point number is described by:
// 
//          (-1)**S * 2**(E-Bias) * 1.F
// 
//    It is declared as follows:
// 
//          double identifier;
// 
//          +------+------+------+------+------+------+------+------+
//          |byte 0|byte 1|byte 2|byte 3|byte 4|byte 5|byte 6|byte 7|
//          S|    E   |                    F                        |
//          +------+------+------+------+------+------+------+------+
//          1|<--11-->|<-----------------52 bits------------------->|
//          <-----------------------64 bits------------------------->
//                                         DOUBLE-PRECISION FLOATING-POINT
// 
//    Just as the most and least significant bytes of a number are 0 and 3,
//    the most and least significant bits of a double-precision floating-
//    point number are 0 and 63.  The beginning bit (and most significant
//    bit) offsets of S, E , and F are 0, 1, and 12, respectively.  Note
//    that these numbers refer to the mathematical positions of the bits,
//    and NOT to their actual physical locations (which vary from medium to
//    medium).
// 
//    The IEEE specifications should be consulted concerning the encoding
//    for signed zero, signed infinity (overflow), and denormalized numbers
//    (underflow) [3].  According to IEEE specifications, the "NaN" (not a
//    number) is system dependent and should not be used externally.
// 
// ------------------------------------------------------------------------
// 
//    [3]  "IEEE Standard for Binary Floating-Point Arithmetic", ANSI/IEEE
//         Standard 754-1985, Institute of Electrical and Electronics
//         Engineers, August 1985.
// 
// ------------------------------------------------------------------------
// 

- (double)percent
{
    double	temp;
    int		i;
    
    for(i = 1; i < 8; i++) {
        if(curbyte == unit) {				// i.e., bytebuffer empty.
	    [engine makeRandom:bytebuffer];
	    curbyte = 0;
	}
	((uchar *)(&temp))[i] = bytebuffer[curbyte];
	curbyte++;
    }
    
    ((ulong *)(&temp))[0] &= ((ulong)0x000fffff);
    ((ulong *)(&temp))[0] |= ((ulong)0x3ff00000);
    
    return (temp - 1.0);
}


//
// bool
//

- (BOOL)bool
{
    BOOL	ret;
    
    if(curbit == 8) {
	if(curbyte == unit) {
	    [engine makeRandom:bytebuffer];
	    curbyte = 0;
	}
	bitbuffer = bytebuffer[curbyte];
	curbyte++;
	curbit = 0;
    }
    
    ret = (bitbuffer & (0x01 << curbit) != 0);
    curbit++;
	    
    return ret;
}


//
// randFunc:
//

- (double)randFunc:(ddfunc)func
{
    return (*func)([self percent]);
}


//
// read:
//

- read:(NXTypedStream *)stream
{
    int		i;
    
    [super read:stream];
    
    //
    // Read in the engine:
    //
    
    NXReadTypes(stream, "@", &engine);
    
    //
    // Set related instance variables:
    //
    
    engineClass	= [engine class];
    unit	= [engineClass unit];
    bytebuffer	= (uchar *)malloc(unit);
    curbit	= 0;
    curbyte	= 0;
    
    //
    // Read in the buffers and buffer pointers:
    //
    
    NXReadTypes(stream, "c", &bitbuffer);
	
    for(i = 0; i < unit; i++) {
        NXReadTypes(stream, "c", &(bytebuffer[i]));
    }
    
    NXReadTypes(stream, "ii", &curbit, &curbyte);
    
    return self;
}


//
// write:
//

- write:(NXTypedStream *)stream
{
    int		i;
    
    [super write:stream];
    
    //
    // Write out the engine:
    //
    
    NXWriteTypes(stream, "@", &engine);
    
    //
    // Write out the buffers and buffer pointers:
    //
    
    NXWriteTypes(stream, "c", &bitbuffer);
    
    for(i = 0; i < unit; i++) {
        NXWriteTypes(stream, "c", &(bytebuffer[i]));
    }
    
    NXWriteTypes(stream, "ii", &curbit, &curbyte);
    
    return self;
}


@end


//
// End of file.
//
