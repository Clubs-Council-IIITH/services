#!/bin/bash

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 [pull|push]"
    exit 1
fi

case "$1" in
    pull)
        git submodule foreach "git pull origin master; git remote prune origin"
        git pull origin master; git remote prune origin
        ;;
    push)
        git submodule foreach "git push origin master"
        git push origin master
        ;;
    *)
        echo "Error: The parameter must be 'pull', or 'push'"
        exit 1
        ;;
esac
