.PHONY: all clean

sub_name=cmd/my-app-1

$(shell mkdir -p $(R_TARGET_DIR)/$(sub_name))

sources_cc = $(wildcard *.cc)

objs_cc = $(patsubst %.cc,$(R_TARGET_DIR)/$(sub_name)/%.cc.o,$(sources_cc))

all: $(R_TARGET_DIR)/my-app-1


$(R_TARGET_DIR)/$(sub_name)/%.cc.o: %.cc
	$(CXX) $(MY_CXXFLAGS) -c $< -o $@

$(R_TARGET_DIR)/my-app-1: $(objs_cc)
	$(CXX) $(MY_CXXFLAGS) $(EXTRA_LIB_FLAG) $(objs_cc) -o $@
