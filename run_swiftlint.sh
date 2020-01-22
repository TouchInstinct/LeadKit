#!/bin/sh

readonly CONFIG_PATH=${PROJECT_DIR}/build-scripts/xcode/.swiftlint.yml

readonly SWIFTLINT_VERSION=0.31.0
readonly SWIFTLINT_PORTABLE_FILENAME=portable_swiftlint.zip

readonly SWIFTLINT_PORTABLE_URL=https://github.com/realm/SwiftLint/releases/download/${SWIFTLINT_VERSION}/${SWIFTLINT_PORTABLE_FILENAME}

. build-scripts/xcode/aux_scripts/download_file.sh ${SWIFTLINT_PORTABLE_FILENAME} ${SWIFTLINT_PORTABLE_URL} Downloads --remove-cached

cd Downloads && unzip -o ${SWIFTLINT_PORTABLE_FILENAME}

${PROJECT_DIR}/Downloads/swiftlint autocorrect --path ${PROJECT_DIR}/Sources --config ${CONFIG_PATH} && ${PROJECT_DIR}/Downloads/swiftlint --path ${PROJECT_DIR}/Sources --config ${CONFIG_PATH}