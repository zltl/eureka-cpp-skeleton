

URL=https://github.com/google/googletest/archive/refs/tags/release-1.12.1.zip
FILE_NAME=googletest-release-1.12.1.zip
SHA256=24564e3b712d3eb30ac9a85d92f7d720f60cc0173730ac166f27dda7fed76cb2
FILE_PATH=${DOWNLOAD_DIR}/${FILE_NAME}
SOURCE_FOLDER=${R_TARGET_DIR}/googletest-release-1.12.1

d_check_rebuild() {
    check_file_exists ${DEPS_INSTALL_DIR}/include/gtest/gtest.h
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
          ..
    cd ..

    cd $OLD_DIR
}
