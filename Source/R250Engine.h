//
// R250Engine
//
// This is an Objective-C class which uses
// the Random architecture from
// Gregor N. Purdy.
//
// The R250Engine class implements a random number generator that is
// reasonably fast.
//
// The algorithm used by the R250Engine class is that given in the article:
//   "A Fast Pseudo Random Number Generator" by W.L. Maier
//   Dr. Dobb's Journal, 1991 May, Page 152.
//   Published By:
//        M&T Publishing, Inc.
//        501 Galveston Drive
//        Redwood City, CA 94063
//        415-366-3600
//
// $Id: R250Engine.h,v 1.2 2004/05/04 14:09:39 gregor Exp $
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

#ifndef _H_R250Engine
#define _H_R250Engine

#include "RandomEngine.h"


@interface R250Engine : RandomEngine


{
    unsigned long	buffer[250];
    int			index;
}


+ (int)unit;

- init;

- makeRandom:(uchar *)storage;

- read:(TypedStream *)stream;
- write:(TypedStream *)stream;


@end

#endif // _H_R250Engine

//
// End of file.
//
