

URL=https://github.com/google/double-conversion/archive/refs/tags/v3.2.1.zip
FILE_NAME=double-conversion-3.2.1.zip
SHA256=55aa41b463346b1032585c04fe7d0adec9db56598d8d699841cdadeb3597e909
FILE_PATH=${DOWNLOAD_DIR}/${FILE_NAME}
SOURCE_FOLDER=${R_TARGET_DIR}/double-conversion-3.2.1

d_check_rebuild() {
    check_file_exists ${DEPS_INSTALL_DIR}/include/double-conversion/bignum.h
}

