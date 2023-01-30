.PHONY: all mylibs cmd clean

.ONESHELL:

all: cmd


cmd: mylibs
	$(MAKE) -C cmd

mylibs:
	for d in $$(ls | grep -v cmd); do
		if [ -d $$d ]; then
			$(MAKE) -C $$d
		fi
	done

clean:
	for d in $$(ls | grep -v cmd); do
		if [ -d $$d ]; then
			$(MAKE) clean -C $$d
		fi
	done
	$(MAKE) clean -C cmd
