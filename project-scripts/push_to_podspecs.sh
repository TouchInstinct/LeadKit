#!/bin/sh

# Find source dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

cd "$DIR"

# Push changes
find ../ -name '*.podspec' \
	-not -path "./Carthage/*" \
	-not -path "./*/Carthage/*" \
	-not -path "./Pods/*" \
	-not -path "./*/Pods/*" \
	| xargs -I% pod repo push git@github.com:TouchInstinct/Podspecs % --allow-warnings