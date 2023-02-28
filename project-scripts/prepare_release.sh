#!/bin/sh

# Description:
#   Prepares new changes to release.
#
# Parameters:
#   $1 - new version
#
# Required environment variables:
#   SRCROOT - path to project folder.
#
# Examples of usage:
#   . prepare_release.sh 1.34.1
#

. ${SRCROOT}/project-scripts/gen_docs_from_playgrounds.sh

. ${SRCROOT}/project-scripts/bump_version.sh $1