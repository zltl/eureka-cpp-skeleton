.PHONY: all clean run_banchmark

.ONESHELL:

OBJ_DIR:=$(R_TARGET_DIR)/benchmarks
$(shell mkdir -p $(OBJ_DIR))

O:=$(OBJ_DIR)

all: $(OBJ_DIR)/my_basic_bench

run_benchmark:
	for r in $$(ls $(R_TARGET_DIR)/benchmarks/); do
		fullr=$(R_TARGET_DIR)/benchmarks/$$r
		if [ -x $$fullr ]; then
			$$fullr
		fi
	done


$(OBJ_DIR)/my_basic_bench: $(O)/basic_bench.cc.o
	$(CXX) $(MY_CXXFLAGS) $(EXTRA_LIB_FLAG) $^ -o $@ -lbenchmark -lpthread

$(OBJ_DIR)/%.cc.o: %.cc
	$(CXX) $(MY_CXXFLAGS) $(EXTRA_INCLUDE_FLAG) $(MODECFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR)

