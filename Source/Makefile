#
# Random
#
# Version 2.1 Makefile.
#
# Copyright (C) 1992-2004 Gregor N. Purdy. All Rights Reserved.
#
# This file is part of Random.
#
# Random is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# Random is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Random; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#


#
# Macros:
#

FLAGS	= -g -Wall
LIBS	= -lNeXT_s -lsys_s


#
# Rules:
#

.m.o:
	cc -c ${FLAGS} -o $@ $*.m


#
# Dependencies:
#

all: TestPercent TestDieRoller TestGaussian TestArchive


#
# Engine Classes:
#

RandomEngine.o: RandomEngine.m RandomEngine.h
StandardEngine.o: StandardEngine.m StandardEngine.h RandomEngine.h
ElkinsEngine.o: ElkinsEngine.m ElkinsEngine.h RandomEngine.h
R250Engine.o: R250Engine.m R250Engine.h RandomEngine.h

ENGINE_HDRS = RandomEngine.h StandardEngine.h ElkinsEngine.h R250Engine.h
ENGINE_OBJS = RandomEngine.o StandardEngine.o ElkinsEngine.o R250Engine.o


#
# Random Classes:
#

Random.o: Random.m Random.h RandomEngine.h
DieRoller.o: DieRoller.m DieRoller.h Random.h
Gaussian.o: Gaussian.m Gaussian.h Random.h


#
# Testing Programs:
#

TestPercent.o: TestPercent.m Random.h ${ENGINE_HDRS}
TestDieRoller.o: TestDieRoller.m Random.h DieRoller.h RandomEngine.h ElkinsEngine.h
TestGaussian.o: TestGaussian.m Random.h Gaussian.h ${ENGINE_HDRS}
TestArchive.o: TestArchive.m Random.h ${ENGINE_HDRS}

TestPercent: TestPercent.o Random.o ${ENGINE_OBJS}
	cc ${FLAGS} -o TestPercent TestPercent.o Random.o ${ENGINE_OBJS} ${LIBS}

TestDieRoller: TestDieRoller.o Random.o DieRoller.o RandomEngine.o ElkinsEngine.o
	cc ${FLAGS} -o TestDieRoller TestDieRoller.o Random.o DieRoller.o \
	   RandomEngine.o ElkinsEngine.o ${LIBS}

TestGaussian: TestGaussian.o Random.o Gaussian.o ${ENGINE_OBJS}
	cc ${FLAGS} -o TestGaussian TestGaussian.o Random.o Gaussian.o ${ENGINE_OBJS} ${LIBS}

TestArchive: TestArchive.o Random.o ${ENGINE_OBJS}
	cc ${FLAGS} -o TestArchive TestArchive.o Random.o ${ENGINE_OBJS} ${LIBS}


# 
# Special targets:
# 

default:
	make all

clean:
	rm -f *.o TestPercent TestDieRoller TestGaussian TestArchive ArchivedRandom.rand

over:
	@make clean
	@make

#
# End of file.
#
