LIB_PATH=/usr/lib/x86_64-linux-gnu
INC_PATH=/usr/include
LUA_VERSION=5.3

fennel-static-filesystem: main.fnl luafilesystem/src/lfs.a
	CC_OPTS=-static fennel --compile-binary $< $@ \
		$(LIB_PATH)/liblua$(LUA_VERSION).a $(INC_PATH)/lua$(LUA_VERSION)/ \
		--native-module luafilesystem/src/lfs.a
	strip fennel-static-filesystem

luafilesystem/src/lfs.o:
	$(MAKE) -C luafilesystem LUA_VERSION=$(LUA_VERSION)

luafilesystem/src/lfs.a: luafilesystem/src/lfs.o
	ar rcs $@ $< $(LIB_PATH)/liblua$(LUA_VERSION).a

.PHONY: clean
clean:
	rm -f luafilesystem/src/lfs.a
	$(MAKE) -C luafilesystem clean

