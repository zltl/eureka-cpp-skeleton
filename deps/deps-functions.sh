# unset before include spec file
unset URL
unset FILE_NAME
unset FILE_PATH
unset SHA256
unset SOURCE_FOLDER


check_file_exists() {
    FNAME=$1
    if [ -f ${FNAME} ]; then
        echo -n "already build"
    else
        echo -n ""
    fi
}

# predefine functions
d_check_rebuild() {
    echo "Use default d_check_rebuild()"
}

d_decompress() {
    echo "Use default d_decompress()"
    set +e
    echo ${FILE_PATH} | grep -q -e '\.zip$'
    rflag=$?
    set -e
    if [ ${rflag} -eq 0 ]; then
        unzip -q -o ${FILE_PATH} -d ${R_TARGET_DIR}
    else
        tar -xf ${FILE_PATH} -C ${R_TARGET_DIR}
    fi
}

d_configure() {
    echo "Use default d_configure"
    OLD_DIR=$PWD
    cd ${SOURCE_FOLDER}

    DBG=Release
#    if [ -z ${RELEASE} ]; then
#        DBG=Debug
#    fi

    if [ -f ./CMakeLists.txt ]; then
        # try cmake
        mkdir -p build
        cd build
        cmake -DCMAKE_INSTALL_PREFIX=${DEPS_INSTALL_DIR} -DCMAKE_BUILD_TYPE=${DBG}  ..
        cd ..
    elif [ -x ./configure ]; then
        ./configure --prefix=${DEPS_INSTALL_DIR}
    fi
    cd $OLD_DIR
}

d_build() {
    echo "Use default d_build"
    OLD_DIR=$PWD
    cd ${SOURCE_FOLDER}

    DBG=Release
#    if [ -z ${RELEASE} ]; then
#        DBG=Debug
#    fi

    # prefer cmake
    if [ -f CMakeLists.txt ]; then
        # for cmake
        cd build
        cmake --build . --config ${DBG}
        cd ..
    elif [ -f Makefile ]; then
        make -j $(nproc)
    fi
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

d_cleanup() {
    echo "Use default d_cleanup"
    rm -rf ${SOURCE_FOLDER}
}
