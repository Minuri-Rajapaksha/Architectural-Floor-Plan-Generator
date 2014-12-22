#tabstop=4
##======================================================================/
## File:   $Id: Makefile,v 1.3 1999/05/05 13:46:41 fadushin Exp $
## Author: Fred Dushin <fadushin@syr.edu>
## Date:   $Date: 1999/05/05 13:46:41 $
##
## Description:  
##
##
##----------------------------------------------------------------------/
## Copyright (C) 1998  Fred Dushin
## 
## This library is free software; you can redistribute it and/or
## modify it under the terms of the GNU Library Public License
## as published by the Free Software Foundation; either version 2
## of the License, or (at your option) any later version.
## 
## This library is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Library Public License for more details.
##======================================================================/

SRCROOTDIR = ..

include $(SRCROOTDIR)/rules.mk

PACKAGENAME = 
PACKAGEPATH = 

SOURCES= \
	Test.java \
	Time.java 

all one: classes
	javac -d ./classes -classpath $(CLASSDESTDIR):$(CLASSPATH) $(SOURCES)

classes:
	mkdir classes

clean:
	rm -f classes/$(SOURCES:.java=.class)

remove:
	rm -rf classes

build: clean remove all
