//
// Random
//
// An Objective-C class for NeXT computers to provide services for random
// number generation.
//
// History:
//   pre 1990 Mar 23
//     Used random number generation algorithm from K&R.
//   1990 Mar 23
//     Modified to use algorithm with cycle length of 8.8 trillion.
//   1990 Mar 26
//     * Added archiving.
//     * Added randMax:, randMin:Max:, and percent:.
//   1991 Apr 26
//     * Changed to use +alloc and -init as all NeXTStep 2.0 objects should.
//   1991 May 30
//     * Prepared for distribution and initial release.
//   1991 Nov 05
//     * Added - (BOOL)bool method.
//   1991 Dec 30
//     * Changed - (float)percent to return double instead.
//     * Added - (double)randFunc: method.
//   1992 Feb 27
//     * Added Gaussian functionality.
//   1992 Apr 02
//     * New version, 2.0.
//     * New Architecture: Split generation/interpretation.
//   2004 May 01
//     * License change to GPL.
//
// Version 2.1, 2004 May 01 
//
// Written by Gregor N. Purdy
// gregor@focusresearch.com
//
// See the README file included for information
// and distribution and usage rights. 
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


#import <objc/Object.h>
#import <objc/typedstream.h>
#import "RandomEngine.h"


#define RAND_RANGE	((ulong)0xffffffff)


typedef double (*ddfunc)(double);			// Double Function Returning Double.


@interface Random : Object


{
    id		engineClass;		// Class for generation.
    ulong	unit;			// Unit of generation for generation class.
    ulong	bufsize;		// unit / 8.
    uchar	*bitbuffer;		// Buffer of random bits.
    uchar	*bytebuffer;		// Buffer of random bits.
    ulong	curbit;			// Current location in the buffer.
    ulong	curbyte;		// Current location in the buffer.
    id		engine;			// The actual engine.
}


+ (int)version;				// Version of the class.

- initEngineClass:aClass;		// Use the class given for generation.
- initEngineInstance:anObject;		// Use the instance given for generation.
					//   THIS IS THE DESIGNATED INITIALIZER.

- (ulong)rand;				// Return a random integer.
- (ulong)randMax:(ulong)max;		// Return a random integer 0 <= x <= max.
- (ulong)randMin:(ulong)min		// Return a random integer min <= x <= max.
    max:(ulong)max;
- (double)percent;			// Return a random double 0.0 <= x <= 1.0.
- (BOOL)bool;				// Return randomly, YES or NO.

- (double)randFunc:(ddfunc)func;	// See description file.

- read:(NXTypedStream *)stream;		// De-archive from a typed stream.
- write:(NXTypedStream *)stream;	// Archive to a typed stream.


@end


//
// End of file.
//
