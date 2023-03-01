#!/bin/sh

# Description:
#   Pushes podspec files to Podspecs repo
#
# Parameters:
#   $1 - additional parameters for pod repo push command
#
# Required environment variables:
#   SRCROOT - path to project folder.
#
# Examples of usage:
#   SRCROOT=`pwd` ./project-scripts/push_to_podspecs.sh
#

for module_name in $(cat ${SRCROOT}/project-scripts/ordered_modules_list.txt); do
    bundle exec pod repo push git@github.com:TouchInstinct/Podspecs ${SRCROOT}/${module_name}/${module_name}.podspec "$@" --allow-warnings
done
