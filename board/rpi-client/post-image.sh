#!/bin/sh

# Part of snapcastbox
#
# Creates zip file wit  all files for 

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

mkdir "${GENIMAGE_TMP}"

cp "${BINARIES_DIR}"/bcm*.dtb "${GENIMAGE_TMP}"
cp "${BINARIES_DIR}/rpi-firmware/bootcode.bin" "${GENIMAGE_TMP}"
cp "${BR2_EXTERNAL_SNAPCASTBOX_PATH}/board/rpi-client/rpi-firmware/cmdline.txt" "${GENIMAGE_TMP}"
cp "${BR2_EXTERNAL_SNAPCASTBOX_PATH}/board/rpi-client/rpi-firmware/config.txt" "${GENIMAGE_TMP}"
cp "${BR2_EXTERNAL_SNAPCASTBOX_PATH}/board/rpi-client/rpi-firmware/wpa_supplicant.conf" "${GENIMAGE_TMP}"
cp "${BINARIES_DIR}/rpi-firmware/fixup.dat" "${GENIMAGE_TMP}"
cp "${BINARIES_DIR}/rpi-firmware/start.elf" "${GENIMAGE_TMP}"
echo snapcastbox >"${GENIMAGE_TMP}/hostname"
cp "${BINARIES_DIR}/zImage" "${GENIMAGE_TMP}"

cd "${BINARIES_DIR}"
zip -vj "${BINARIES_DIR}/snapcastbox-rpiclient" "${GENIMAGE_TMP}"/*

rm -rf "${GENIMAGE_TMP}" 

exit $?
