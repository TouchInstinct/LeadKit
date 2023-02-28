#!/bin/sh

# Find source dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

cd "$DIR"

for module_name in $(cat ordered_modules_list.txt); do
    bundle exec pod repo push git@github.com:TouchInstinct/Podspecs ${module_name}/${module_name}.podspec --allow-warnings
done
