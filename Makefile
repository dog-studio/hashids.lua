INSTALLDIR=/lua_package/hashids

UNAME := $(shell uname -s)

all:
ifeq ($(UNAME),Darwin)
	@echo building for OS X
	gcc -bundle -undefined dynamic_lookup -I/usr/local/include/ -o src/clib.so src/clib.c
else
	@echo building for Linux
	gcc -Wall -shared -fPIC -I/usr/local/openresty/luajit/include/luajit-2.1 -o src/clib.so src/clib.c
endif

install:
	@echo installing lib
	@mkdir -p /lua_package
	@mkdir -p $(INSTALLDIR)
	cp src/init.lua $(INSTALLDIR)
	cp src/clib.so $(INSTALLDIR)

clean:
	@echo Cleaning...
	@rm -f src/clib.so
