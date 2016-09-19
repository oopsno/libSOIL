MAKE = make
CC = gcc
INSTALL_FILE = install -p -o root -g admin -m 644
INSTALL_DIR = install -o root -g admin -d
LN = ln -s
RM = rm -fv
CFLAGS += -c -O2 -Wall -Iinclude
LDFLAGS += -framework OpenGL -framework CoreFoundation

CFILES = src/image_DXT.c src/image_helper.c src/SOIL.c src/stb_image_aug.c
OFILES = $(CFILES:.c=.o)
LIBNAME = libSOIL
VERSION = 1.07-20071110
MAJOR = 1

HFILES = include/SOIL.h include/image_DXT.h include/image_helper.h \
  include/stbi_DDS_aug.h include/stbi_DDS_aug_c.h include/stb_image_aug.h
AFILE = libSOIL.a
DYLIBFILE = libSOIL.dylib
INCLUDEDIR = opt/local/include/SOIL
LIBDIR = opt/local/lib

all: $(OFILES) lib

%.o: %.c
	$(CC) $(CFLAGS) $< -o $@

lib: $(OFILES)
	# create static library
	ar -cvq $(LIBNAME).a $(OFILES)
	# create shared library
	gcc -dynamiclib -o $(DYLIBFILE) $(OFILES) $(LDFLAGS)\
	 	-install_name $(DESTDIR)/$(LIBDIR)/$(DYLIBFILE)

install:
	$(INSTALL_DIR) $(DESTDIR)/$(INCLUDEDIR)
	$(INSTALL_FILE) $(HFILES) $(DESTDIR)/$(INCLUDEDIR)
	$(INSTALL_DIR) $(DESTDIR)/$(LIBDIR)
	$(INSTALL_FILE) $(AFILE) $(DESTDIR)/$(LIBDIR)
	$(INSTALL_FILE) $(DYLIBFILE) $(DESTDIR)/$(LIBDIR)
#	( cd $(DESTDIR)/$(LIBDIR) && $(LN) $(SOFILE) $(LIBNAME).so.$(MAJOR) \
	  && $(LN) $(SOFILE) $(LIBNAME).so )

clean:
	$(RM) *.o
	$(RM) *~

distclean:
	$(RM) $(AFILE) $(SOFILE)

.PHONY: all lib clean distclean
