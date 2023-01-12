.PHONY: deps clean my-app-1

.ONESHELL:

PROJECT_ROOT:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
TARGET_DIR ?= $(PROJECT_ROOT)/target

# If in debug mode, build all target to ./target/debug/...,
# else build to ./target/release/...
ifneq ($(RELEASE),)
	R_TARGET_DIR = $(TARGET_DIR)/release
	C_COMMON_FLAGS = -O3
else
	DEBUG_FLAGS = -DDEBUG -g
	R_TARGET_DIR = $(TARGET_DIR)/debug
endif

DEPS_INSTALL_DIR = $(R_TARGET_DIR)/deps

EXTRA_INCLUDE_FLAG=-I$(DEPS_INSTALL_DIR)/include -I$(PROJECT_ROOT)/src
EXTRA_LIB_FLAG=-L$(DEPS_INSTALL_DIR)/lib

$(shell mkdir -p $(R_TARGET_DIR))
$(shell mkdir -p $(R_TARGET_DIR)/deps/{include,lib})

ifneq ($(SANITIZE),)
	ifneq ($(DEBUG_FLAGS),)
		DEBUG_FLAGS += -g
	endif
	DEBUG_FLAGS += -fsanitize=address -lasan
endif

# use C++23
USE_CXX_VERSION=2b

MY_C_COMMON_FLAGS += -Werror -Wall -Wextra -pedantic
MY_C_STANDARD := -std=c17
MY_CXX_STANDARD := -std=c++${USE_CXX_VERSION} -fmodules-ts '-fmodule-mapper=|@g++-mapper-server -r'$(R_TARGET_DIR)/gcm

# flags pass to CC only
MY_CFLAGS:= $(MY_C_COMMON_FLAGS) $(DEBUG_FLAGS) $(MY_C_STANDARD)
# flags pass to CXX only
MY_CXXFLAGS:= $(MY_C_COMMON_FLAGS) $(MY_CXX_STANDARD)

# export all variables that defined
export

DEPS_GET:= $(PROJECT_ROOT)/deps/deps.sh

all:
	echo "nothing"

my-app-1:
	$(MAKE) -C src/cmd/my-app-1
my-app-1/clean:
	rm -rf $(R_TARGET_DIR)/cmd/my-app-1/
	rm -rf $(R_TARGET_DIR)/my-app-1

deps:
	$(DEPS_GET) boost-1.18.0.rc1
	$(DEPS_GET) openssl-3.0.7

clean: my-app-1/clean

