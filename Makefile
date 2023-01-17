.PHONY: deps clean src my boost_example my_example test build run_test benchmark run_benchmark

.ONESHELL:

# CC=clang
# CXX=clang++
CC=gcc
CXX=g++

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
EXTRA_LIB_FLAG=-L$(DEPS_INSTALL_DIR)/lib -L$(DEPS_INSTALL_DIR)/lib64

$(shell mkdir -p $(R_TARGET_DIR))
$(shell mkdir -p $(R_TARGET_DIR)/deps/{include,lib})
$(shell mkdir -p $(R_TARGET_DIR)/obj)
$(shell mkdir -p $(R_TARGET_DIR)/pcm)
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
MY_CXX_STANDARD := -std=c++${USE_CXX_VERSION}


# flags pass to CC only
MY_CFLAGS:= $(MY_C_COMMON_FLAGS) $(DEBUG_FLAGS) $(MY_C_STANDARD)
# flags pass to CXX only
MY_CXXFLAGS:= $(MY_C_COMMON_FLAGS) $(MY_CXX_STANDARD) \
	      -fmodules-ts '-fmodule-mapper=|@g++-mapper-server -r'$(R_TARGET_DIR)/pcm
	      # -fcompare-debug-second \

# export all variables that defined
export

DEPS_GET:= $(PROJECT_ROOT)/deps/deps.sh

all: build test benchmark

build: boost_example my_example options_example

my: deps
	$(MAKE) -C src/my
boost_example: deps my
	$(MAKE) -C src/cmd/boost_example
my_example: deps my
	$(MAKE) -C src/cmd/my_example
options_example: deps
	$(MAKE) -C src/cmd/options_example

test: build
	$(MAKE) -C tests

run_test: test
	for r in $$(ls $(R_TARGET_DIR)/tests/); do
		fullr=$(R_TARGET_DIR)/tests/$$r
		if [ -x $$fullr ]; then
			$$fullr
		fi
	done

benchmark: build
	$(MAKE) -C benchmarks

run_benchmark: benchmark
	for r in $$(ls $(R_TARGET_DIR)/benchmarks/); do
		fullr=$(R_TARGET_DIR)/benchmarks/$$r
		if [ -x $$fullr ]; then
			$$fullr
		fi
	done

deps:
	$(DEPS_GET) googletest-1.12.1
	$(DEPS_GET) benchmark-1.7.1
	$(DEPS_GET) boost-1.18.0.rc1
	# $(DEPS_GET) openssl-3.0.7
	# $(DEPS_GET) spdlog-1.11.0
	$(DEPS_GET) fmt-9.1.0
	# $(DEPS_GET) double-conversion-3.2.1


clean:
	$(MAKE) clean -C src/my
	$(MAKE) clean -C src/cmd/boost_example
	$(MAKE) clean -C src/cmd/my_example
	$(MAKE) clean -C src/cmd/options_example
	$(MAKE) clean -C tests
