.PHONY: all clean

OBJ_DIR:=$(R_TARGET_DIR)/cmd/my_example
$(shell mkdir -p $(OBJ_DIR))

mylibs = $(wildcard $(R_TARGET_DIR)/*.a)

all: $(R_TARGET_DIR)/my_example

$(R_TARGET_DIR)/my_example: $(OBJ_DIR)/main.cc.o $(mylibs)
	$(CXX) $(MY_CXX_FLAGS) $(EXTRA_LIB_FLAGS) -o $@ $(R_TARGET_DIR)/libmy.a $^

$(OBJ_DIR)/%.cc.o: %.cc
	$(CXX) $(MY_CXXFLAGS) $(EXTRA_INCLUDE_FLAG) -c $< -o $@

clean:
	rm -rf $(R_TARGET_DIR)/my_example
	rm -rf $(OBJ_DIR)


