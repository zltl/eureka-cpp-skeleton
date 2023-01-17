.PHONY: all clean

CURR_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
# $(sub_name) is the folder's name that have a Makefile including this file.
# For examploe: .../path/to/mylibx --> sub_name=mylibx
sub_name = $(shell basename $(CURR_DIR))

# Create a folder at ./target/... to contain xxx.o files.
OBJ_DIR:=$(R_TARGET_DIR)/$(sub_name)
$(shell mkdir -p $(OBJ_DIR))

sources_c = $(wildcard *.cc)
objs_cc = $(patsubst %.cc,$(OBJ_DIR)/%.cc.o,$(sources_c))

# We locate libxyz.a to ./target/{debug/release}/libxyz.a, not $(OBJ_DIR).
all: $(R_TARGET_DIR)/lib$(sub_name).a

$(OBJ_DIR)/%.cc.o: %.cc
	$(CXX) $(MY_CXXFLAGS) $(EXTRA_INCLUDE_FLAG) $(CMODFLAG) -c $< -o $@
$(R_TARGET_DIR)/lib$(sub_name).a: $(objs_cc)
	$(AR) rcs $@ $^

clean:
	rm -rf $(OBJ_DIR)
	rm -rf $(R_TARGET_DIR)/lib$(sub_name).a
