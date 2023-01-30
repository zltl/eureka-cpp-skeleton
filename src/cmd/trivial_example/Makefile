# Build every files xxyyzz.cc to xxyyzz
# Asume that every xxyyzz.cc files have a main function.

.PHONY: all clean

CURR_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
sources_c = $(wildcard *.cc)
exes_cc = $(patsubst %.cc,$(R_TARGET_DIR)/trivial_%_example,$(sources_c))
objs_cc = $(patsubst %.cc,$(OBJ_DIR)/%.cc.o,$(sources_c))
mylibs = $(wildcard $(R_TARGET_DIR)/*.a)

OBJ_DIR:=$(R_TARGET_DIR)/cmd/trivial_example
$(shell mkdir -p $(OBJ_DIR))

mlibs = -lmy \
	-llogging \
	-lspdlog \
	-lboost_filesystem \
	-lboost_thread \
	-lboost_chrono \
	-lfmt

all: $(exes_cc)

# MODECFLAGS := -static

$(R_TARGET_DIR)/trivial_%_example :$(OBJ_DIR)/%.cc.o $(mylibs)
	$(CXX) $(MY_CXXFLAGS) $(EXTRA_LIB_FLAG) $^ -o $@ $(mlibs)

$(OBJ_DIR)/%.cc.o: %.cc
	$(CXX) $(MY_CXXFLAGS) $(EXTRA_INCLUDE_FLAG) $(MODECFLAGS) -c $< -o $@

clean:
	rm -rf $(exes_cc)
	rm -rf $(OBJ_DIR)

