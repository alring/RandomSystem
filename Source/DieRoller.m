//
// DieRoller
//
// $Id: DieRoller.m,v 1.3 2004/05/04 14:23:45 gregor Exp $
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


#include "DieRoller.h"


@implementation DieRoller


//
//rollDie:
//

- (int)rollDie:(int) numSides
{
    return [self randMax:(numSides - 1)] + 1;
}


//
// roll:die:
//

- (int)roll:(int) numRolls die:(int) numSides
{
    int temp = 0;
    int loop;
	
    for (loop = 1 ; loop <= numRolls ; loop++ )
	temp += [self rollDie:numSides];
	
    return temp;
}


//
// rollBest:of:die:
//

- (int) rollBest:(int)numWanted of:(int)numRolls die:(int)numSides
{
    int temp[numRolls];				// Array of rolls
    int loop1;					// First loop control variable
    int loop2;					// Second loop control variable
    int highest;				// Index of highest found roll
    int accumulator = 0;			// Accumulates total best roll
	
    for (loop1 = 1 ; loop1 <= numRolls ; loop1++)	// Fill an array with rolls
	temp[loop1] = [self rollDie:numSides];
	
    for (loop1 = 1 ; loop1 <= numWanted; loop1++) {
	highest = 1;				// Start off as if first is highest
	for (loop2 = 2 ; loop2 <= numRolls ; loop2++)	// Scan array for higher rolls
	    if (temp[loop2] > temp[highest])	// If temp[loop2] is higher, then
		highest = loop2;		//     remember that fact
	accumulator += temp[highest];		// Add highest roll to accumulator
	temp[highest] = 0;			// Clear highest roll so we don't find it again
    }
	
    return accumulator;				// Return what we found
}


@end


//
// End of file.
//
