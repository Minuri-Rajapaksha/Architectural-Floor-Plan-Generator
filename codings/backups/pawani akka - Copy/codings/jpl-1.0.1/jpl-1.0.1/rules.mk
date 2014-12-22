##======================================================================/
## File:   $Id: rules.mk,v 1.10 1999/05/05 20:29:30 fadushin Exp $
## Author: Fred Dushin <fadushin@top.cis.syr.edu>
## Date:   $Date: 1999/05/05 20:29:30 $
##
## Description:  This file defines several variables and rules
## used by make.  Change the noted variables based on the
## configuration of your system.
##
## 
##----------------------------------------------------------------------/
## Copyright (C) 1998  Fred Dushin
## 
## This program is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License
## as published by the Free Software Foundation; either version 2
## of the License, or (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##======================================================================/

# 
# Change these varibles to suit your system
#
# Note: 
#     SRCROOTDIR will be set from within
#     the Makefile that includes this file
#

#
# The location of the java distribution
#
JAVA_HOME = /opt/java

# 
# This is the directory that holds the JNI include file
# specific for your platform.  It should be subdirectory in
# $(JAVA_HOME)/include
# 
PLATFORM_INCLUDE = genunix

#
# The location of the SWI-Prolog distribution (/usr/local by default)
#
#PL_HOME = /usr/local
PL_HOME = /opt/pl
PL_VERSION = 3.1.2
#PL_VERSION = 3.2.5

# 
# This is the directory in the PL_HOME lib/runtime directory that contains
# libpl.a.  It will vary across platforms
# 
PLATFORM_LIB = powerpc-linux
#PLATFORM_LIB = i686-linux

#
# this is where we will put the JAR, ZIP, and .so files
#
LIBDIR= $(SRCROOTDIR)/lib

#
# this is where we put all the classes
#
CLASSDESTDIR= $(LIBDIR)/classes

#
# This is where we put the documentation
#
DOCDESTDIR= $(SRCROOTDIR)/doc/api



#############################################
# The rest of this file should stay the same#
#############################################

#JAVACFLAGS= -g -d $(CLASSDESTDIR) -classpath $(CLASSDESTDIR):$(CLASSPATH) -nowarn
JAVACFLAGS= -O -d $(CLASSDESTDIR) -classpath $(CLASSDESTDIR):$(CLASSPATH) -nowarn
JAVAC=javac
JCC=$(JAVAC) $(JAVACFLAGS)
	
%.o : %.java
	$(JCC) $<
	touch $@

JAVACC=javacc
JAVACCFLAGS= 
JCCC=$(JAVACC) $(JAVACCFLAGS)
	
%.done : %.jj
	$(JCCC) $<


JAVAH=javah
JAVAHFLAGS= -jni -classpath $(SRCROOTPATH)/lib/classes:$(JAVA_HOME)/lib/classes.zip
JH= $(JAVAH) $(JAVAHFLAGS)

CC= gcc
CIFLAGS=-I. -I$(SRCROOTPATH)/include -I$(PL_HOME)/lib/pl-$(PL_VERSION)/include -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/$(PLATFORM_INCLUDE)
CFLAGS= -fPIC -c $(CIFLAGS)

LD = gcc
LDFLAGS = -shared 
LDLIBS = -L$(PL_HOME)/lib/pl-$(PL_VERSION)/runtime/$(PLATFORM_LIB) -lpl -ldl -lreadline -ltermcap -lm

