
URL=https://github.com/google/benchmark/archive/refs/tags/v1.7.1.zip
FILE_NAME=benchmark-1.7.1.zip
SHA256=aeec52381284ec3752505a220d36096954c869da4573c2e1df3642d2f0a4aac6
FILE_PATH=${DOWNLOAD_DIR}/${FILE_NAME}
SOURCE_FOLDER=${R_TARGET_DIR}/benchmark-1.7.1

d_check_rebuild() {
    check_file_exists ${DEPS_INSTALL_DIR}/include/benchmark/benchmark.h
}

d_configure() {
    OLD_DIR=$PWD
    cd ${SOURCE_FOLDER}

    DBG=Release
#    if [ -z ${RELEASE} ]; then
#        DBG=Debug
#    fi

    # try cmake
    mkdir -p build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=${DEPS_INSTALL_DIR} \
          -DCMAKE_BUILD_TYPE=${DBG} \
          -DBENCHMARK_ENABLE_TESTING=OFF \
          ..
    cd ..

    cd $OLD_DIR
}
