//
// TestGaussian
//
// This program tests the RandomSystem classes' abilities to generate
// random gaussian variables.
//
// $Id: TestGaussian.m,v 1.3 2004/05/04 14:23:45 gregor Exp $
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


#include "Gaussian.h"
#include "StandardEngine.h"
#include "ElkinsEngine.h"
#include "R250Engine.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>


#define DEFAULT_N	1000
#define DEFAULT_M	10
#define RANGE		3.5

#define MAX_BAR		40


//
// test_gaussian()
//

int test_gaussian(id myRand, int m, int n)
{
    int			max = 0;		// Size of largest bin.
    int			i;			// Generic loop variable.
    int			j;			// Generic loop variable.
    double		x;			// The random number.
    int			slot;			// The sorted position of a number.
    int			barsize;		// The length of a result bar.
    int			*binneg;		// The bin array (dynamically allocated).
    int			*binpos;		// The bin array (dynamically allocated).
    int			which;
    int			total = 0;
    
    //
    // Allocate and initialize slot array:
    //
    
    binneg = (int *)malloc(m * sizeof(int));
    binpos = (int *)malloc(m * sizeof(int));
    for(i = 0; i < m; i++) {
        binneg[i] = 0;
	binpos[i] = 0;
    }
    
    //
    // Make n random numbers:
    //
        
    for(i = 0; i < n; i++) {
        do {
	    x = [myRand gaussian];
//	    printf("Made gaussian %f\n", x);
	} while (x == 0.0);
	
	total++;
	which = (x > 0);
	slot = (int)floor(fabs(x) * m / RANGE);
	if((slot >= 0) && (slot < m) && (x != 0.0)) {		// If it is in range,
	    switch(which) {					//   count it.
	        case 0:
		    if((++binneg[slot]) > max) {
			max = binneg[slot];
		    }
		    break;
		case 1:
		    if((++binpos[slot]) > max) {
			max = binpos[slot];
		    }
		    break;
		default:
		    printf("Why is which = %d?\n", which);
		    break;
	    }
	}
    }
    
    //
    // Print the results:
    //
    
    for(i = m - 1; i >= 0; i--) {
        printf("%+1.6f to %+1.6f: %6d:", -((i + 1) * (RANGE / m)),
		-(i * (RANGE / m)), binneg[i]);
	
	barsize = (int)((double)binneg[i] / ((double)max / (double)MAX_BAR));
	for(j = 0; j < barsize; j++)
	    printf("*");
	printf("\n");
    }
    for(i = 0; i < m; i++) {
        printf("%+1.6f to %+1.6f: %6d:", i * (RANGE / m), (i + 1) * (RANGE / m), binpos[i]);
	
	barsize = (int)((double)binpos[i] / ((double)max / (double)MAX_BAR));
	for(j = 0; j < barsize; j++)
	    printf("*");
	printf("\n");
    }
    
    printf("Max   = %6d\n", max);
    printf("Total = %6d\n", total);
    
    //
    // Clean up:
    //
    
    free(binneg);
    free(binpos);
    
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
    id			myRand;			// Random number generator.
    int			n;			// Quantity of numbers to generate.
    int			m;			// Number of bins in which to sort them.
    
    myRand = [[Gaussian alloc] initEngineClass:[ElkinsEngine class]];
    
    switch(argc) {
        case 2:
	    sscanf(argv[1], "%d", &n);
	    m = DEFAULT_M;
	    break;
	case 3:
	    sscanf(argv[1], "%d", &n);
	    sscanf(argv[2], "%d", &m);
	    break;
	default:
	    n = DEFAULT_N;
	    m = DEFAULT_M;
	    break;
    }
    
    printf("TestGaussian: Testing StandardEngine class:\n");
    myRand = [[Gaussian alloc] initEngineClass:[StandardEngine class]];
    test_gaussian(myRand, m, n);
    printf("\n\n");
    [myRand free];
    
    printf("TestGaussian: Testing ElkinsEngine class:\n");
    myRand = [[Gaussian alloc] initEngineClass:[ElkinsEngine class]];
    test_gaussian(myRand, m, n);
    printf("\n\n");
    [myRand free];
    
    printf("TestGaussian: Testing R250Engine class:\n");
    myRand = [[Gaussian alloc] initEngineClass:[R250Engine class]];
    test_gaussian(myRand, m, n);
    printf("\n\n");
    [myRand free];
    
    return 0;
}


//
// End of file.
//
