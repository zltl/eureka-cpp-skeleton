

URL=https://www.openssl.org/source/openssl-3.0.7.tar.gz
FILE_NAME=openssl-3.0.7.tar.gz
SHA256=83049d042a260e696f62406ac5c08bf706fd84383f945cf21bd61e9ed95c396e
FILE_PATH=${DOWNLOAD_DIR}/${FILE_NAME}
SOURCE_FOLDER=${R_TARGET_DIR}/openssl-3.0.7

d_check_rebuild() {
    if [ -f ${DEPS_INSTALL_DIR}/include/openssl/ssl.h ]; then
        echo -n "already build"
    else
        echo -n ""
    fi
}

d_configure() {
    OLD_DIR=$PWD
    cd ${SOURCE_FOLDER}

    if [ -x ${RELEASE} ]; then
        ./config no-shared --prefix=${DEPS_INSTALL_DIR}
    else
        ./config -d no-shared --prefix=${DEPS_INSTALL_DIR}
    fi

    cd $OLD_DIR
}
