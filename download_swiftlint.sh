#!/bin/sh

SWIFTLINT_VERSION=0.31.0
SWIFTLINT_PORTABLE_FILENAME=portable_swiftlint.zip

SWIFTLINT_PORTABLE_URL=https://github.com/realm/SwiftLint/releases/download/${SWIFTLINT_VERSION}/${SWIFTLINT_PORTABLE_FILENAME}

rm ${PROJECT_DIR}/Downloads/${SWIFTLINT_PORTABLE_FILENAME}

. ${PROJECT_DIR}/build-scripts/xcode/aux_scripts/download_file.sh ${SWIFTLINT_PORTABLE_FILENAME} ${SWIFTLINT_PORTABLE_URL}

cd Downloads && unzip -o ${SWIFTLINT_PORTABLE_FILENAME}