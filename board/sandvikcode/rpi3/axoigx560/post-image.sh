#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# Special cmdline.txt for Axotec IGX-560
cp ${BOARD_DIR}/cmdline.txt ${BINARIES_DIR}/

# Special config.txt for Axotec IGX-560
cp ${BOARD_DIR}/config.txt ${BINARIES_DIR}/

# Use the dbto files from Axotec
cp -r ${BOARD_DIR}/overlays ${BINARIES_DIR}/

# Use the dt-blob.bin from Axotec
cp -r ${BOARD_DIR}/dt-blob.bin ${BINARIES_DIR}/


rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
