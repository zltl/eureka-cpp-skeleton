.PHONY: all clean

OBJ_DIR:=$(R_TARGET_DIR)/cmd/boost_example
$(shell mkdir -p $(OBJ_DIR))

all: $(R_TARGET_DIR)/boost_example

$(R_TARGET_DIR)/boost_example: $(OBJ_DIR)/main.cc.o $(R_TARGET_DIR)/libmy.a
	$(CXX) $(MY_CXX_FLAGS) $(EXTRA_LIB_FLAGS) $(R_TARGET_DIR)/libmy.a -lboost_chrono -lfmt $^ -o $@

$(OBJ_DIR)/%.cc.o: %.cc
	$(CXX) $(MY_CXXFLAGS) \
	       $(EXTRA_INCLUDE_FLAG) \
	       -fmodules-ts \
	       -flang-info-include-translate-not \
	       -c $< -o $@
	
clean:
	rm -rf $(R_TARGET_DIR)/boost_example
	rm -rf $(OBJ_DIR)

