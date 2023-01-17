eureka-cpp-skeleton
---

eureka-cpp-skeleton is a project skeleton that uses c++20 module.

To build example:

```sh
make deps
make

./target/debug/my_example
./target/debug/boost_example

make run_test
make run_benchmark
```

# Structures

## Makefile
The makefile of project. Only support `make` currently. You should
modify it if you want to build your own program.

Every folder containing source codes should have a `Makefile`. If it
is a static library, just `include $(PROJECT_ROOT)/makes/sublib.make`.
If the folder containing `main()`, normally locate at `src/cmd/xxx`,
just copy a makefile from `src/cmd/my_example` and modify it as need.

## ./deps
All dependencies spec files and install scripts. If you want to use
other dependencies, just create a new `deps-xxx-x.y.z.sh` file, and
edit contants like other `deps-xxxxxxx` files.

After adding `deps-xxxxxx` file, add a commands like
`$(DEPS_GET) googletest-1.12.1` to the `deps` target.

## Benchmarks and Unit Tests
See `benchmarks` and `tests` folders.

## ./src/cmd/...
All executable source codes should locate here, each program per
folder, use program name as it's folder name. Edit a `Makefile` like
`options_example`, it's simple enought, I think.


## ./src/...
Module/component should be build as a static library, then link to
`./src/cmd/...` programs. See folder `./src/my/`

## ./target
All build result will be in folder `./target`, including dependencies.

# lsp

To generate `compile_commands.json` install `bear`.

```sh
sudo emerge --ask bear
bear -- make
```
