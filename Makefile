#############################################################
# Cross-platform Makefile (Linux and macOS).
#
# cfitsio is located automatically, in this order:
#   1. Command-line override:
#        make CFITSIOINCDIR=/path/to/include LIBDIR=/path/to/lib
#   2. pkg-config (apt, dnf, conda-forge and most Homebrew
#      installs ship cfitsio.pc)
#   3. Homebrew prefix (macOS)
#   4. The cfitsio in an activated conda environment
#   5. The compiler default search paths (e.g. /usr/include,
#      /usr/lib) - works when a system cfitsio-dev package is
#      installed
#
#############################################################

UNAME_S := $(shell uname -s)

CFITSIOINCDIR ?=
LIBDIR        ?=

ifneq ($(CFITSIOINCDIR),)
    CFITSIOINC := -I$(CFITSIOINCDIR)
else
    CFITSIOINC := $(shell pkg-config --cflags cfitsio 2>/dev/null)
endif

ifneq ($(LIBDIR),)
    CFITSIOLIB := -L$(LIBDIR) -lcfitsio
else
    CFITSIOLIB := $(shell pkg-config --libs cfitsio 2>/dev/null)
endif

ifeq ($(CFITSIOINC)$(CFITSIOLIB),)
    ifeq ($(UNAME_S),Darwin)
        BREW_PREFIX := $(shell brew --prefix cfitsio 2>/dev/null)
        ifneq ($(BREW_PREFIX),)
            CFITSIOINC := -I$(BREW_PREFIX)/include
            CFITSIOLIB := -L$(BREW_PREFIX)/lib -lcfitsio
        endif
    endif
    ifneq ($(CONDA_PREFIX),)
        ifneq ($(wildcard $(CONDA_PREFIX)/include/fitsio.h),)
            CFITSIOINC := -I$(CONDA_PREFIX)/include
            CFITSIOLIB := -L$(CONDA_PREFIX)/lib -lcfitsio
        endif
    endif
endif
ifeq ($(CFITSIOLIB),)
    CFITSIOLIB := -lcfitsio
endif

#
#
#############################################################
# COMPILATION OPTIONS BELOW
#

# another good memory checker is valgrind : http://valgrind.kde.org/index.html
# valgrind --tool=memcheck hotpants

# for memory checking with libefence
# LIBS  = $(CFITSIOLIB) -lm -lefence

# for profiling with gprof
# COPTS = -pg -fprofile-arcs -funroll-loops -O3 -ansi -pedantic-errors -Wall $(CFITSIOINC)

# for debugging
#COPTS = -g3 -funroll-loops -O3 -ansi -pedantic-errors -Wall $(CFITSIOINC)

# standard usage
# (-D_GNU_SOURCE exposes gethostname() and other POSIX calls under -ansi)
COPTS = -funroll-loops -O3 -ansi -std=c99 -pedantic-errors -Wall $(CFITSIOINC) -D_GNU_SOURCE
LIBS  = $(CFITSIOLIB) -lm

# compiler
CC    = gcc

#
#
#############################################################
# BELOW SHOULD BE OK, UNLESS YOU WANT TO COPY THE EXECUTABLES
# SOMEPLACE AFTER THEY ARE BUILT eg. hotpants
#

STDH  = functions.h globals.h defaults.h
ALL   = main.o vargs.o alard.o functions.o globals.o

all:	hotpants extractkern maskim

hotpants: $(ALL)
	$(CC) $(ALL) -o hotpants $(LIBS) $(COPTS)

main.o: $(STDH) main.c
	$(CC) $(COPTS)  -c main.c

alard.o: $(STDH) alard.c
	$(CC) $(COPTS)  -c alard.c

functions.o: $(STDH) functions.c
	$(CC) $(COPTS)  -c functions.c

vargs.o: $(STDH) vargs.c
	$(CC) $(COPTS)  -c vargs.c

globals.o: $(STDH) globals.c
	$(CC) $(COPTS)  -c globals.c

extractkern : extractkern.o
	$(CC) extractkern.o -o extractkern $(LIBS) $(COPTS)

extractkern.o : $(STDH) extractkern.c
	$(CC) $(COPTS)  -c extractkern.c

maskim : maskim.o
	$(CC) maskim.o -o maskim $(LIBS) $(COPTS)

maskim.o: $(STDH) maskim.c
	$(CC) $(COPTS)  -c maskim.c

clean :
	rm -f *.o
	rm -f *~ .*~
	rm -f hotpants
	rm -f extractkern
	rm -f maskim
