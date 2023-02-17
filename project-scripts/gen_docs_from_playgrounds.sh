#!/bin/sh

# Description:
#   Generates markdown documentation from nef playgrounds.
#
# Required environment variables:
#   SRCROOT - path to project folder.
#

PLAYGROUNDS="${SRCROOT}/TIFoundationUtils/TIFoundationUtils.app"

for playground_path in ${PLAYGROUNDS}; do
    nef compile --project ${playground_path} --use-cache
    nef markdown --project ${playground_path} --output ../docs
done