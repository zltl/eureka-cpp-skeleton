

URL=https://github.com/fmtlib/fmt/releases/download/9.1.0/fmt-9.1.0.zip
FILE_NAME=fmt-9.1.0.zip
SHA256=cceb4cb9366e18a5742128cb3524ce5f50e88b476f1e54737a47ffdf4df4c996
FILE_PATH=${DOWNLOAD_DIR}/${FILE_NAME}
SOURCE_FOLDER=${R_TARGET_DIR}/fmt-9.1.0

d_check_rebuild() {
    check_file_exists ${DEPS_INSTALL_DIR}/include/fmt/format.h
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
          -DFMT_TEST=OFF \
          ..
    cd ..

    cd $OLD_DIR
}
