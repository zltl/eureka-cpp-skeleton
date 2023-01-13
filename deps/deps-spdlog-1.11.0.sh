

URL=https://codeload.github.com/gabime/spdlog/zip/refs/tags/v1.11.0
FILE_NAME=spdlog-1.11.0.zip
SHA256=33f83c6b86ec0fbbd0eb0f4e980da6767494dc0ad063900bcfae8bc3e9c75f21
FILE_PATH=${DOWNLOAD_DIR}/${FILE_NAME}
SOURCE_FOLDER=${R_TARGET_DIR}/spdlog-1.11.0


d_check_rebuild() {
    if [ -f ${DEPS_INSTALL_DIR}/include/spdlog/spdlog.h ]; then
        echo -n "already build"
    else
        echo -n ""
    fi
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
          -DSPDLOG_BUILD_EXAMPLE=OFF \
          ..
    cd ..

    cd $OLD_DIR
}
