

URL=https://boostorg.jfrog.io/artifactory/main/release/1.81.0/source/boost_1_81_0_rc1.zip
FILE_NAME=boost_1_81_0_rc1.zip
SHA256=6e689b266b27d4db57f648b1e5c905c8acd6716b46716a12f6fc73fc80af842e
FILE_PATH=${DOWNLOAD_DIR}/${FILE_NAME}
SOURCE_FOLDER=${R_TARGET_DIR}/boost_1_81_0

d_check_rebuild() {
    check_file_exists ${DEPS_INSTALL_DIR}/include/boost/config.hpp
}

d_configure() {
    OLD_DIR=$PWD
    cd ${SOURCE_FOLDER}

    # CC are gcc or clang
    ./bootstrap.sh --prefix=${DEPS_INSTALL_DIR} --with-toolset=${CC}

    cd $OLD_DIR
}

d_build() {
    OLD_DIR=$PWD
    cd ${SOURCE_FOLDER}

    if [ -z ${RELEASE} ]; then
        ./b2 install threading=multi variant=debug link=static
    else
        ./b2 install threading=multi variant=release link=static
    fi

    cd $OLD_DIR
}

d_install() {
    # ignore
    echo ""
}
