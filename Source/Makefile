#
# Random
#
# Copyright (C) 1992-2004 Gregor N. Purdy. All Rights Reserved.
#
# $Id: Makefile,v 1.3 2004/05/04 14:23:45 gregor Exp $
#
# This file is part of RandomSystem.
#
# RandomSystem is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# RandomSystem is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with RandomSystem; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#


#
# Macros:
#

FLAGS = -g -Wall
LIBS  = -lobjc -lm


#
# Rules:
#

%.o: %.m
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

RANDOM_HDRS = Random.h DieRoller.h Gaussian.h
RANDOM_OBJS = Random.o DieRoller.o Gaussian.o


#
# Other variables:
#

ALL_HDRS = ${RANDOM_HDRS} ${ENGINE_HDRS}
ALL_OBJS = ${RANDOM_OBJS} ${ENGINE_OBJS}


#
# Testing Programs:
#

TestPercent.o: TestPercent.m ${ALL_HDRS}
TestDieRoller.o: TestDieRoller.m ${ALL_HDRS}
TestGaussian.o: TestGaussian.m ${ALL_HDRS}
TestArchive.o: TestArchive.m ${ALL_HDRS}

TestPercent: TestPercent.o Random.o ${ALL_OBJS}
	cc ${FLAGS} -o TestPercent TestPercent.o ${ALL_OBJS} ${LIBS}

TestDieRoller: TestDieRoller.o ${ALL_OBJS}
	cc ${FLAGS} -o TestDieRoller TestDieRoller.o ${ALL_OBJS} ${LIBS}

TestGaussian: TestGaussian.o ${ALL_OBJS}
	cc ${FLAGS} -o TestGaussian TestGaussian.o ${ALL_OBJS} ${LIBS}

TestArchive: TestArchive.o Random.o ${ALL_OBJS}
	cc ${FLAGS} -o TestArchive TestArchive.o ${ALL_OBJS} ${LIBS}


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
