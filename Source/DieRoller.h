//
// DieRoller
//
// $Id: DieRoller.h,v 1.3 2004/05/04 14:23:45 gregor Exp $
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


@interface DieRoller : Random


{
}


- (int)rollDie:(int)numSides;		// Return a random integer 1 <= x <= numSides.
- (int)roll:(int)numRolls		// Return the best numWanted of numRolls rolls.
  die:(int)numSides;
- (int)rollBest:(int)numWanted		// Return integer sum of best numWanted rolls.
  of:(int)numRolls
  die:(int)numSides;


@end


//
// End of file.
//
