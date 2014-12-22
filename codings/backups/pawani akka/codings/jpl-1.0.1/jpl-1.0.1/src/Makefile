#tabstop=4
##======================================================================/
## File:   $Id: Makefile,v 1.4 1999/05/05 13:46:37 fadushin Exp $
## Author: Fred Dushin <fadushin@syr.edu>
## Date:   $Date: 1999/05/05 13:46:37 $
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

SRCROOTPATH = ..

include $(SRCROOTPATH)/rules.mk

PACKAGENAME = jpl
PACKAGEPATH = jpl
PACKAGEMANGLE = jpl_


%.o : %.c
	$(CC) $(CFLAGS) -o $@ $<

IMPL = \
	$(PACKAGEMANGLE)fli_Prolog.c \

JNI= \
	$(PACKAGENAME).fli.Prolog \

GEN_H = \
	$(PACKAGEMANGLE)fli_Prolog.h \

SOURCES = \
	$(IMPL) \
	
LIBNAME = \
	jpl

SUBDIRS = \


all: $(GEN_H) $(SRCROOTPATH)/lib/lib$(LIBNAME).so


$(GEN_H):
	$(JH) $(JNI)

$(SRCROOTPATH)/lib/lib$(LIBNAME).so: $(IMPL) $(SOURCES:.c=.o)
	$(LD) $(LDFLAGS) -Wl,-soname,$(LIBNAME).so -o $(SRCROOTPATH)/lib/lib$(LIBNAME).so $(SOURCES:.c=.o) $(LDLIBS)

clean:
	rm -f $(IMPL:.c=.o) $(SOURCES:.c=.o) $(GEN_H)

remove:
	rm -rf $(SRCROOTPATH)/lib/lib$(LIBNAME).so

build: clean remove all
