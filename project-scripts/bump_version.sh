#!/bin/sh

# Find source dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

cd "$DIR"

# Bump version
find ../ -name '*.podspec' \
	-not -path "../Carthage/*" \
	-not -path "../*/Carthage/*" \
	-not -path "../Pods/*" \
	-not -path "../*/Pods/*" \
	-not -path "../*/.gem/*" \
	| xargs -I% npx podspec-bump -i "$1" -w -p %
