//
// ElkinsEngine
//
// This is an Objective-C class which uses
// the Random architecture from
// Gregor N. Purdy.
//
// The ElkinsEngine class implements a random number generator with a cycle
// length of 8.8 trillion.
// 
// Upon creation of an ElkinsEngine, the seeds are set using the system clock.
// Three calls are made to the system clock function, and for each the 
// microseconds are used as the seed value. Thus, the relationships between
// the seeds are dependant upon system load.
//
// The algorithm used by the ElkinsEngine class is that given in the article:
//   "A Higly Random Random-Number Generator" by T.A. Elkins
//   Computer Language, 1989 December (Volume 6, Number 12), Page 59.
//   Published by:
//        Miller Freeman Publications
//        500 Howard Street
//        San Francisco, CA 94105
//        415-397-1881
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


#import "RandomEngine.h"


@interface ElkinsEngine : RandomEngine


{
    ushort	h1, h2, h3;		// Seeds.
}


+ (ulong)unit;

- init;
- initSeeds:(ushort)s1			// Init with seeds given.
  :(ushort)s2
  :(ushort)s3;

- newSeeds;				// Get seeds from system time.
- setSeeds:(ushort) s1			// Set seeds to those given.
  :(ushort) s2
  :(ushort) s3;
- getSeeds:(ushort *)s1			// Put the seeds into some vars.
  :(ushort *)s2
  :(ushort *)s3;

- makeRandom:(uchar *)storage;

- read:(NXTypedStream *)stream;
- write:(NXTypedStream *)stream;


@end


//
// End of file.
//
