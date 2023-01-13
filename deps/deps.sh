#!/usr/bin/env bash

set -e

# exported variables:
#   CC - gcc/clang
#   CXX - g++/clang++
#   PROJECT_ROOT - source code folder path
#   RELEASE - seted if build as release mode
#   TARGET_DIR $PROJECT_ROOT/target or anypath that user specified
#   R_TARGET_DIR real target folder, ${TARGET_DIR}/debug or ${TARGET_DIR}/release
#   DOWNLOAD_DIR - the folder that contains all dependencys that downloads
#   DEPS_INSTALL_DIR - install prefix of all deps
#   USE_CXX_VERSION - 20/23 ...

# PROJECT_ROOT=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && cd .. && pwd )

# color echo
RED='\033[0;31m'
NC='\033[0m' # No Color
ERROR() {
    msg=$1
    echo -e "${RED}Error: ${msg}${NC}"
}

# export C_INCLUDE_PATH=${DEPS_INSTALL_DIR}/include
# export CPLUS_INCLUDE_PATH=${C_INCLUDE_PATH}
# export LD_LIBRARY_PATH=${DEPS_INSTALL_DIR}/lib
export DOWNLOAD_DIR=${TARGET_DIR}/downloads
mkdir -p ${DOWNLOAD_DIR}

DEPS_NAME=$1
DEPS_SCRIPT=${PROJECT_ROOT}/deps/deps-${DEPS_NAME}.sh

source ${PROJECT_ROOT}/deps/deps-functions.sh

echo "Try installing ${DEPS_NAME}"
echo "Checking deps spec file ${DEPS_SCRIPT}"
if [ -f ${DEPS_SCRIPT} ]; then
    echo "Found spec, trying import ${DEPS_SCRIPT}"
    source ${DEPS_SCRIPT}
else
    ERROR "Spec ${DEPS_SCRIPT} not found"
    exit 111
fi

# check if need rebuild
need_rebuild_s=$(d_check_rebuild)
if [[ ! -z ${need_rebuild_s} ]]; then
    echo "${DEPS_NAME} already build, skip"
    exit 0
fi

# Check if need download
NEED_DOWNLOAD="no"
if [ -f ${FILE_PATH} ]; then
    H=$(sha256sum ${FILE_PATH} | awk '{print $1}')
    if [ ${H} = ${SHA256} ]; then
        echo "Already downloaded, skip download"
    else
        echo "${FILE_PATH} hash mismatch, get ${H}, expected ${SHA256}, downloading"
        NEED_DOWNLOAD="yes"
    fi
else
    echo "${FILE_PATH} not exists, downloading"
    NEED_DOWNLOAD="yes"
fi

# download
if [ ${NEED_DOWNLOAD} = "yes" ]; then
   curl -L ${URL} -o ${FILE_PATH}
   H=$(sha256sum ${FILE_PATH} | awk '{print $1}')
   echo "Checking hash with downloaded file"
   if [ ${H} = ${SHA256} ]; then
       echo "Download success"
   else
       ERROR "Download ${URL} failed, sha256 mismatch: download hash is ${H}, expected ${SHA256}"
   fi
fi

set -x
echo "Decompressing ${FILE_PATH} ..."
d_decompress
echo "configure ..."
d_configure
echo "build ..."
d_build
echo "install ..."
d_install
echo "clean up deps source folder ${SOURCE_FOLDER} ..."
d_cleanup
set +x

