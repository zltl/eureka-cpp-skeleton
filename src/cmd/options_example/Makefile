.PHONY: all clean

OBJ_DIR:=$(R_TARGET_DIR)/cmd/options_example
$(shell mkdir -p $(OBJ_DIR))

all: $(R_TARGET_DIR)/options_example

MODECFLAGS := -fmodules-ts -static

$(R_TARGET_DIR)/options_example: $(OBJ_DIR)/main.cc.o $(OBJ_DIR)/options.cc.o
	$(CXX) $(MY_CXXFLAGS) $(EXTRA_LIB_FLAG) $^ -o $@ -lboost_program_options -lfmt -o $@

$(OBJ_DIR)/%.cc.o: %.cc
	$(CXX) $(MY_CXXFLAGS) $(EXTRA_INCLUDE_FLAG) $(MODECFLAGS) -c $< -o $@

clean:
	rm -rf $(R_TARGET_DIR)/options_example
	rm -rf $(OBJ_DIR)

