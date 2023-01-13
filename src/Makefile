.PHONY: all clean my_example boost_example

CUR_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OBJ_DIR:=$(R_TARGET_DIR)/obj

SRC_FILES := $(shell find . ! -name "*_main.cc" -name "*.cc")
# SRC_FILES := $(wildcard *.cc)

objs_cc = $(patsubst %.cc,$(OBJ_DIR)/%.cc.o,$(SRC_FILES))

all: my_example boost_example

my_example: $(R_TARGET_DIR)/my_example

my_example/clean:
	rm -rf $(R_TARGET_DIR)/my_example
	rm -rf $(objs_cc) $(OBJ_DIR)/my_example_main.cc.o
$(R_TARGET_DIR)/my_example: $(objs_cc) $(OBJ_DIR)/my_example_main.cc.o
	$(CXX) $(MY_CXX_FLAGS)  $(EXTRA_LIB_FLAGS) -lboost_chrono -lfmt $^ -o $@

boost_example: $(R_TARGET_DIR)/boost_example
boost_example/clean:
	rm -rf $(R_TARGET_DIR)/boost_example
	rm -rf $(objs_cc) $(OBJ_DIR)/boost_example_main.cc.o

$(R_TARGET_DIR)/boost_example: $(objs_cc) $(OBJ_DIR)/boost_example_main.cc.o
	$(CXX) $(MY_CXX_FLAGS) $(EXTRA_LIB_FLAGS) -lboost_chrono -lfmt $^ -o $@

$(OBJ_DIR)/%.cc.o: %.cc
	$(CXX) $(MY_CXXFLAGS) \
	       $(EXTRA_INCLUDE_FLAG) \
	       -fmodules-ts \
	       -flang-info-include-translate-not \
	       -c $< -o $@

clean: my_example/clean boost_example/clean
	rm -rf gcm.cache
	rm -rf $(OBJ_DIR)


