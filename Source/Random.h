//
// Random
//
// An Objective-C class for to provide services for random number generation.
//
// Written by Gregor N. Purdy
// gregor@focusresearch.com
//
// See the README file included for information
// and distribution and usage rights. 
//
// $Id: Random.h,v 1.2 2004/05/04 14:09:39 gregor Exp $
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


#ifndef _H_Random
#define _H_Random

#include <objc/Object.h>
#include <objc/typedstream.h>
#include "RandomEngine.h"


#define RAND_RANGE	((ulong)0xffffffff)


typedef double (*ddfunc)(double);			// Double Function Returning Double.


@interface Random : Object


{
    id		engineClass;		// Class for generation.
    ulong	unit;			// Unit of generation for generation class.
    uchar	bitbuffer;		// Buffer of random bits.
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

- read:(TypedStream *)stream;		// De-archive from a typed stream.
- write:(TypedStream *)stream;	// Archive to a typed stream.


@end

#endif // _H_Random

//
// End of file.
//
