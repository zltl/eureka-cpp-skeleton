.PHONY: all run_test clean

OBJ_DIR:=$(R_TARGET_DIR)/tests
$(shell mkdir -p $(OBJ_DIR))

O:=$(OBJ_DIR)

all: $(OBJ_DIR)/my_unit_test

MODECFLAGS := -static

my_unit_object := $(O)/basic_test.cc.o \
		  $(O)/fixture_test.cc.o \
		  $(O)/turtle.cc.o \
		  $(O)/mock_test.cc.o

run_test:
	for r in $$(ls $(R_TARGET_DIR)/tests/); do
		fullr=$(R_TARGET_DIR)/tests/$$r
		if [ -x $$fullr ]; then
			$$fullr
		fi
	done

$(OBJ_DIR)/my_unit_test: $(my_unit_object)
	$(CXX) $(MY_CXXFLAGS) $(EXTRA_LIB_FLAG) $^ -o $@ -lgtest -lgtest_main -lgmock -lgmock_main

$(OBJ_DIR)/%.cc.o: %.cc
	$(CXX) $(MY_CXXFLAGS) $(EXTRA_INCLUDE_FLAG) $(MODECFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR)

