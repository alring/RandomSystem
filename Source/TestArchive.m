//
// TestArchive
//
// This program tests the archiving abilities of RandomSystem.
//
// $Id: TestArchive.m,v 1.3 2004/05/04 14:23:45 gregor Exp $
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
#include "StandardEngine.h"
#include "ElkinsEngine.h"
#include "R250Engine.h"
#include <objc/typedstream.h>
#include <stdio.h>


//
// test_archive()
//

void test_archive(id myRand)
{
    double                buffer[1000];
    double                temp;
    int                        i;
    TypedStream        *myStream;
    id                        myNewRand;
    
    //
    // Skip 1000 numbers
    //
    
    printf("  Generating 1000 percentages...\n");
    
    for(i = 0; i < 1000; i++) {
        temp = [myRand percent];
    }
    
    //
    // Archive the random:
    //
    
    printf("  Archiving the random object to the file 'ArchivedRandom.rand'...\n");
    
    myStream = objc_open_typed_stream_for_file("ArchivedRandom.rand", OBJC_WRITEONLY);
    [myRand write:myStream];
    objc_close_typed_stream(myStream);
    
    //
    // Generate and save a bunch of numbers:
    //
    
    printf("  Generating and saving 1000 percentages...\n");
    
    for(i = 0; i < 1000; i++) {
        buffer[i] = [myRand percent];
    }
    
    //
    // De-archive the random:
    //
    
    printf("  Reading a copy of the archive from the file 'ArchivedRandom.rand'...\n");
    
    myStream = objc_open_typed_stream_for_file("ArchivedRandom.rand", OBJC_READONLY);
    myNewRand = [[Random alloc] read:myStream];
    objc_close_typed_stream(myStream);
    
    //
    // Create 1000 more numbers, and compare them:
    //
    
    printf("  Creating and comparing 1000 percentages to previous results...\n");
    
    for(i = 0; i < 1000; i++) {
        double temp = [myNewRand percent];
        if(buffer[i] != temp) {
            printf(">> Sequence diverged at index %d (expected %g; got %g)!\n", i, buffer[i], temp);
            break;
        }
    }
    
    //
    // Free data objects:
    //
    
    printf("  Freeing temporary random number generator...\n");
    
    [myNewRand free];
    
    return;
}


//
// main()
//

int main(int argc, char *argv[])
{
    id myRand;
    
    printf("TestPercent: Testing StandardEngine class:\n");
    myRand = [[Random alloc] initEngineClass:[StandardEngine class]];
    test_archive(myRand);
    printf("\n\n");
    [myRand free];
    
    printf("TestPercent: Testing ElkinsEngine class:\n");
    myRand = [[Random alloc] initEngineClass:[ElkinsEngine class]];
    test_archive(myRand);
    printf("\n\n");
    [myRand free];
    
    printf("TestPercent: Testing R250Engine class:\n");
    myRand = [[Random alloc] initEngineClass:[R250Engine class]];
    test_archive(myRand);
    printf("\n\n");
    [myRand free];
    
    return 0;
}


//
// End of file.
//
