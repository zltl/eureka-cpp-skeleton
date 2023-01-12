.PHONY: deps clean

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

$(shell mkdir -p $(R_TARGET_DIR))
$(shell mkdir -p $(R_TARGET_DIR)/deps/{include,lib})

ifneq ($(SANITIZE),)
	ifneq ($(DEBUG_FLAGS),)
		DEBUG_FLAGS += -g
	endif
	DEBUG_FLAGS += -fsanitize=address -lasan
endif

USE_CXX_VERSION=23

C_COMMON_FLAGS += -Werror -Wall -Wextra -pedantic
C_STANDARD := -std=c17
CXX_STANDARD := -std=c++${USE_CXX_VERSION}

# flags pass to CC
CFLAGS:= $(C_COMMON_FLAGS) $(DEBUG_FLAGS) $(C_STANDARD)
# flags pass to CXX
CXXFLAGS:= $(CXX_STANDARD)

# export all variables that defined
export

all:
	echo "nothing"

deps:
	$(PROJECT_ROOT)/deps/deps.sh boost-1.18.0.rc1

clean:
	echo "nothing"

