//
// ElkinsEngine
//
// This is an Objective-C class which uses the RandomSystem architecture from
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
// $Id: ElkinsEngine.h,v 1.3 2004/05/04 14:23:45 gregor Exp $
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

#ifndef _H_ElkinsEngine
#define _H_ElkinsEngine

#include "RandomEngine.h"


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

- read:(TypedStream *)stream;
- write:(TypedStream *)stream;


@end

#endif // _H_ElkinsEngine

//
// End of file.
//
