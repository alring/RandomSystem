//
// RandomEngine
//
// An abstract Objective-C class for random number
// generator engines.
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


//
// Types:
//

typedef unsigned long	ulong;
typedef unsigned short	ushort;
typedef unsigned char	uchar;


@interface RandomEngine : Object


{
}


+ (int)unit;				// Return the unit of generation (# of BYTES).

- makeRandom:(uchar *)storage;


@end


//
// End of file.
//
