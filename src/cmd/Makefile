.PHONY: cmd_all clean

.ONESHELL:

cmd_all:
	for d in $$(ls | grep -v Makefile); do
		$(MAKE) -C $$d
	done


clean:
	for d in $$(ls | grep -v Makefile); do
		$(MAKE) clean -C $$d
	done

