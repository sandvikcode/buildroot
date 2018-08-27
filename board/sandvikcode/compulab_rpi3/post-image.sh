#!/bin/sh

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

echo "BOARD_DIR=${BOARD_DIR}"
echo "BOARD_NAME=${BOARD_NAME}"
echo "GENIMAGE_CFG=${GENIMAGE_CFG}"
echo "GENIMAGE_TMP=${GENIMAGE_TMP}"
echo "BINARIES_DIR=${BINARIES_DIR}"

cp board/sandvikcode/${BOARD_NAME}/config.txt ${BINARIES_DIR}/config.txt
cp board/sandvikcode/${BOARD_NAME}/cmdline.txt ${BINARIES_DIR}/cmdline.txt

if [ -e ${BINARIES_DIR}/zImage ]; then
    mv ${BINARIES_DIR}/zImage ${BINARIES_DIR}/kernel7.img
fi

rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
