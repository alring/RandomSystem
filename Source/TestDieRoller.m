//
// TestDieRoller
//
// $Id: TestDieRoller.m,v 1.2 2004/05/04 14:09:39 gregor Exp $
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


#include "DieRoller.h"
#include "ElkinsEngine.h"
#include <stdio.h>
#include <stdlib.h>


#define SAMPLES		100000


//
// test_dieroller()
//

int test_dieroller(id roller)
{
    ulong	results[100];
    int		i;
    
    //
    // Test rollDie:
    //
    
    printf("TestDieRoller: Rolling %d 20-sided dice.\n", SAMPLES);
    for(i = 0; i < 20; i++)
        results[i] = 0;
    for(i = 0; i < SAMPLES; i++)
	(results[[roller rollDie:20] - 1])++;
    for(i = 0; i < 20; i++)
        printf("%2d: %ld (%f%%)\n", i + 1, results[i], (double)results[i] / (double)SAMPLES * 100);
    
    printf("\n\n");
    
    //
    // Test roll:die:
    //
    
    //
    // Test rollBest:of:die:
    //
    
    return 0;
}


//
// main()
//

int main(int argc, char *argv[])
{
    id		myRoller;
    
    myRoller = [[DieRoller alloc] initEngineClass:[ElkinsEngine class]];
    
    test_dieroller(myRoller);
    
    return 0;
}


//
// End of file.
//
