LIB_PATH=/usr/lib/x86_64-linux-gnu
INC_PATH=/usr/include

# PUC 5.3
LUA_VERSION=5.3
LUA_LIB_SUFFIX=$(LUA_VERSION)
LUA_INC_SUFFIX=$(LUA_VERSION)

# luajit 2.1 (lua 5.1)
# LUA_VERSION=5.1
# LUA_LIB_SUFFIX=jit-$(LUA_VERSION)
# LUA_INC_SUFFIX=jit-2.1

LUA_LIB=$(LIB_PATH)/liblua$(LUA_LIB_SUFFIX).a
LUA_INC=$(INC_PATH)/lua$(LUA_INC_SUFFIX)

fennel-static-filesystem: main.fnl luafilesystem/src/lfs.a
	echo LUA_LIBRARY=$(LUA_LIB)
	echo LUA_INCLUDE=$(LUA_INC)
	CC_OPTS=-static fennel --compile-binary $< $@ \
		$(LUA_LIB) $(LUA_INC) \
		--native-module luafilesystem/src/lfs.a
	strip fennel-static-filesystem

luafilesystem/src/lfs.o:
	$(MAKE) -C luafilesystem LUA_VERSION=$(LUA_VERSION)

luafilesystem/src/lfs.a: luafilesystem/src/lfs.o
	ar rcs $@ $< $(LUA_LIB)

.PHONY: clean
clean:
	rm -f luafilesystem/src/lfs.a
	$(MAKE) -C luafilesystem clean

