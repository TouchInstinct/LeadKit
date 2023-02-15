#!/bin/sh

# Description:
#   Updates version in podspecs
#
# Parameters:
#   $1 - new version
#
# Required environment variables:
#   SRCROOT - path to project folder.
#
# Examples of usage:
#   . bump_version.sh 1.34.1
#

for module_name in $(cat ${SRCROOT}/project-scripts/ordered_modules_list.txt); do
    npx podspec-bump -i $1 -w -p ${SRCROOT}/${module_name}/${module_name}.podspec
done
