//
// TestPercent
//
// This program tests the Random classes' abilities to generate
// random percentages.
//
// $Id: TestPercent.m,v 1.2 2004/05/04 14:09:39 gregor Exp $
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


#include "Random.h"
#include "StandardEngine.h"
#include "ElkinsEngine.h"
#include "R250Engine.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>


#define DEFAULT_N	10000
#define DEFAULT_M	20


#define MAX_BAR		40


//
// test_percent()
//
// This function takes the id of a prepared Random
// instance and prints out the percent_test
// histogram using it.
//

int test_percent(id myRand, int m, int n)
{
    int		max;				// Size of largest bin.
    int		total;
    int		i;				// Generic loop variable.
    int		j;				// Generic loop variable.
    double	x;				// The random number.
    int		slot;				// The sorted position of a number.
    int		barsize;			// The length of a result bar.
    int		*slots;				// The bin array (dynamically allocated).
    
    //
    // Allocate and initialize slot array:
    //
    
//    printf("Initializing slot array...\n");
    
    slots = (int *)malloc(m * sizeof(int));
    for(i = 0; i < m; i++)
        slots[i] = 0;
    
    //
    // Make n random numbers:
    //
    
//    printf("Making %d random numbers...\n", n);
    
    max = 0;
    for(i = 0; i < n; i++) {
        x = [myRand percent];
	
	slot = (int)floor(x * m);
	if((slot >= 0) && (slot < m)) {		// If it is in range,
	    if((++slots[slot]) > max) {		//   count it.
		max = slots[slot];
	    }
	}
	else {
	    printf(">> Value %f out of range!\n", x);
	}
    }
    
    //
    // Print the results:
    //
    
//    printf("Printing the results...\n");
    
    total = 0;
    for(i = 0; i < m; i++) {
        printf("%1.6f - %1.6f: %6d:", i * (1.0 / m), (i + 1) * (1.0 / m), slots[i]);
	
	total += slots[i];
	barsize = (int)((double)slots[i] / ((double)max / (double)MAX_BAR));
	for(j = 0; j < barsize; j++)
	    printf("*");
	printf("\n");
    }
    
    printf("Max =   %6d\n", max);
    printf("Total = %6d\n", total);
    
    //
    // Clean up:
    //
    
    free(slots);
    
    //
    // Return to caller:
    //
    
    return 0;
}


//
// main()
//

int main(int argc, char *argv[])
{
    id		myRand;				// Random number generator.
    int		n;				// Quantity of numbers to generate.
    int		m;				// Number of slots in which to sort them.
    
    switch(argc) {
        case 2:
	    sscanf(argv[1], "%d", &n);;
	    m = DEFAULT_M;
	    break;
	case 3:
	    sscanf(argv[1], "%d", &n);;
	    sscanf(argv[2], "%d", &m);;
	    break;
	default:
	    n = DEFAULT_N;
	    m = DEFAULT_M;
	    break;
    }
    
    printf("TestPercent: Testing StandardEngine class:\n");
    myRand = [[Random alloc] initEngineClass:[StandardEngine class]];
    test_percent(myRand, m, n);
    printf("\n\n");
    [myRand free];
    
    printf("TestPercent: Testing ElkinsEngine class:\n");
    myRand = [[Random alloc] initEngineClass:[ElkinsEngine class]];
    test_percent(myRand, m, n);
    printf("\n\n");
    [myRand free];
    
    printf("TestPercent: Testing R250Engine class:\n");
    myRand = [[Random alloc] initEngineClass:[R250Engine class]];
    test_percent(myRand, m, n);
    printf("\n\n");
    [myRand free];
    
    return 0;
}


//
// End of file.
//
