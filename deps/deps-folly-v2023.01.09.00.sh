

URL=https://github.com/facebook/folly/releases/download/v2023.01.09.00/folly-v2023.01.09.00.zip
FILE_NAME=folly-v2023.01.09.00.zip
SHA256=3398260a7b866cacafbf871c3613b710d550712b058899c396e26a0859c8aacb
FILE_PATH=${DOWNLOAD_DIR}/${FILE_NAME}
SOURCE_FOLDER=${R_TARGET_DIR}/folly-v2023.01.09.00

d_decompress() {
    unzip -q -o ${FILE_PATH} -d ${R_TARGET_DIR}/folly-v2023.01.09.00
}

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
