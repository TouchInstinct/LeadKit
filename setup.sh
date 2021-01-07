
# Git version >= 2.9
git config core.hooksPath .githooks

# Git version < 2.9
HOOKS_FOLDER=.git/hooks

if [ ! -d $HOOKS_FOLDER ]; then
    mkdir $HOOKS_FOLDER
fi

find .git/hooks -type l -exec rm {} \; && find .githooks -type f -exec ln -sf ../../{} .git/hooks/ \;
chmod +x .githooks