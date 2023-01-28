

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
    echo "ignore"
}


d_build() {
    echo "Use default d_build"
    OLD_DIR=$PWD
    cd ${SOURCE_FOLDER}

    ./build.sh --install-prefix $DEPS_INSTALL_DIR

    cd $OLD_DIR
}

d_install() {
    echo "Use default d_install"
    OLD_DIR=$PWD
    cd ${SOURCE_FOLDER}

    DBG=Release
    if [ -z ${RELEASE} ]; then
        DBG=Debug
    fi

    # prefer cmake
    if [ -f CMakeLists.txt ]; then
        # for cmake
        cd build
        cmake --install . --config ${DBG}
        cd ..
    elif [ -f Makefile ]; then
        make install
    fi

    cd $OLD_DIR
}
