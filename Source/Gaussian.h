//
// Gaussian
//
// $Id: Gaussian.h,v 1.3 2004/05/04 14:23:45 gregor Exp $
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


#include "Random.h"


@interface Gaussian : Random


{
    BOOL	iset;			// For gaussian generation.
    double	gset;
    
    double	gscale;			// Gaussian scaling;
    double	gorigin;		// Gaussian origin;
}


- initEngineInstance:anObject;

- (double)gScale;
- setGScale:(double)aScale;
- (double)gOrigin;
- setGOrigin:(double)anOrigin;
- (double)gaussian;			// Return gausian variable.

- read:(TypedStream *)stream;
- write:(TypedStream *)stream;


@end


//
// End of file.
//
