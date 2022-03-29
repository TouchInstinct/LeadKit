#!/bin/sh

# Find source dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

cd "$DIR"

ORDERED_PODSPECS="../TISwiftUtils/TISwiftUtils.podspec
../TIFoundationUtils/TIFoundationUtils.podspec
../TIKeychainUtils/TIKeychainUtils.podspec
../TIUIKitCore/TIUIKitCore.podspec
../TIUIElements/TIUIElements.podspec
../TITableKitUtils/TITableKitUtils.podspec
../TINetworking/TINetworking.podspec
../TIMoyaNetworking/TIMoyaNetworking.podspec"

for podspec_path in ${ORDERED_PODSPECS}; do
    pod repo push git@github.com:TouchInstinct/Podspecs ${podspec_path} --allow-warnings
done
