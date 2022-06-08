#!/bin/sh

# Find source dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

cd "$DIR"

ORDERED_PODSPECS="../TISwiftUtils/TISwiftUtils.podspec
../TIPagination/TIPagination.podspec
../TIFoundationUtils/TIFoundationUtils.podspec
../TIKeychainUtils/TIKeychainUtils.podspec
../TIUIKitCore/TIUIKitCore.podspec
../TISwiftUICore/TISwiftUICore.podspec
../TIUIElements/TIUIElements.podspec
../TIAuth/TIAuth.podspec
../TITableKitUtils/TITableKitUtils.podspec
../TINetworking/TINetworking.podspec
../TINetworkingCache/TINetworkingCache.podspec
../TIMoyaNetworking/TIMoyaNetworking.podspec
../TIMapUtils/TIMapUtils.podspec
../TIAppleMapUtils/TIAppleMapUtils.podspec
../TIGoogleMapUtils/TIGoogleMapUtils.podspec
../TIYandexMapUtils/TIYandexMapUtils.podspec"

for podspec_path in ${ORDERED_PODSPECS}; do
    bundle exec pod repo push git@github.com:TouchInstinct/Podspecs ${podspec_path} --allow-warnings
done
