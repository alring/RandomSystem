//
// TestArchive
//
// This program tests the archiving abilities of the Random System.
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


#import "Random.h"
#import "StandardEngine.h"
#import "ElkinsEngine.h"
#import "R250Engine.h"
#import <objc/typedstream.h>
#import <stdio.h>


//
// test_archive()
//

void test_archive(id myRand)
{
    double		buffer[1000];
    double		foo;
    int			i;
    NXTypedStream	*myStream;
    id			myNewRand;
    
    //
    // Skip 1000 numbers
    //
    
    printf("  Generating 1000 percentages...\n");
    
    for(i = 0; i < 1000; i++) {
    	foo = [myRand percent];
    }
    
    //
    // Archive the random:
    //
    
    printf("  Archiving the random object to the file 'ArchivedRandom.rand'...\n");
    
    myStream = NXOpenTypedStreamForFile("ArchivedRandom.rand", NX_WRITEONLY);
    [myRand write:myStream];
    NXCloseTypedStream(myStream);
    
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
    
    myStream = NXOpenTypedStreamForFile("ArchivedRandom.rand", NX_READONLY);
    myNewRand = [[Random alloc] read:myStream];
    NXCloseTypedStream(myStream);
    
    //
    // Create 1000 more numbers, and compare them:
    //
    
    printf("  Creating and comparing 1000 percentages to previous results...\n");
    
    for(i = 0; i < 1000; i++) {
    	if(buffer[i] != [myNewRand percent]) {
	    printf(">> Sequence diverged at %d!\n", i);
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
