#!/bin/bash

set -euo pipefail
npx standard-version --skip.changelog --skip.commit  -t ''

echo "RELEASE_VERSION=$(git describe --abbrev=0 | tr -d '\n')" >> $GITHUB_ENV
export VERSION="$(git describe --abbrev=0 | tr -d '\n')"

echo $VERSION

find . -name '*.podspec' | xargs -I% npx podspec-bump -i $VERSION -w -p %

git add -A
git commit --amend --no-edit