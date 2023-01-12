# unset before include spec file
unset URL
unset FILE_NAME
unset FILE_PATH
unset SHA256
unset SOURCE_FOLDER

# predefine functions
d_check_rebuild() {
    echo -n ""
}

d_decompress() {
    if [ $(echo ${FILE_PATH} | grep -q 'zip' ${FILE_PATH}) ]; then
        unzip -q -o ${FILE_PATH} -d ${R_TARGET_DIR}
    else
        tar -xf ${FILE_PATH} -C ${R_TARGET_DIR}
    fi
}

d_configure() {
    OLD_DIR=$PWD
    cd ${SOURCE_FOLDER}

    if [ -x ./configure ]; then
        ./configure --prefix=${DEPS_INSTALL_DIR}
    fi
    cd $OLD_DIR
}

d_build() {
    OLD_DIR=$PWD
    cd ${SOURCE_FOLDER}
    make -j $(nproc)
    cd $OLD_DIR
}

d_install() {
    OLD_DIR=$PWD
    cd ${SOURCE_FOLDER}
    make install
    cd $OLD_DIR
}

d_cleanup() {
    rm -rf ${SOURCE_FOLDER}
}
