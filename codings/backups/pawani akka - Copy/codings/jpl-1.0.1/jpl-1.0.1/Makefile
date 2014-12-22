#tabstop=4
##======================================================================/
## File:   $Id: Makefile,v 1.7 1999/05/05 13:46:06 fadushin Exp $
## Author: Fred Dushin <fadushin@syr.edu>
## Date:   $Date: 1999/05/05 13:46:06 $
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

SRCROOTDIR = .

include $(SRCROOTDIR)/rules.mk

PACKAGENAME = jpl
PACKAGEPATH = jpl

PACKAGES = \
	jpl \
	jpl.fli \

all:
	-mkdir -p $(CLASSDESTDIR)
	cd jsrc/$(PACKAGEPATH); make all
	cd src; make all
	make jar
	make zip
	make html

jar:
	cd $(CLASSDESTDIR); jar cvf $(PACKAGENAME).jar $(PACKAGENAME)
	mv $(CLASSDESTDIR)/$(PACKAGENAME).jar $(LIBDIR)

zip:
	cd $(CLASSDESTDIR); zip -r -0 $(PACKAGENAME).zip $(PACKAGENAME)
	mv $(CLASSDESTDIR)/$(PACKAGENAME).zip $(LIBDIR)

html:
	cd jsrc; javadoc -public -d ../$(DOCDESTDIR) $(PACKAGES)

stamp:
	cat version | xargs stamp.script

export:
	cat version | xargs export.script

webpage:
	cat version | xargs webpage.script

clean:
	cd jsrc/$(PACKAGEPATH); make clean
	cd src; make clean
	cd test; make clean
	cd $(DOCDESTDIR);  rm -f *.html

remove:
	rm -f $(LIBDIR)/$(PACKAGENAME).jar $(LIBDIR)/$(PACKAGENAME).zip
	cd jsrc/$(PACKAGEPATH); make remove
	cd src; make remove
	cd test; make remove

build: clean remove all
