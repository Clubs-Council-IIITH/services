#!/bin/bash

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 [prod|staging|submodules]"
    exit 1
fi

case "$1" in
    prod)
        git push prod master:prod
        ;;
    staging)
        git push prod master:staging
        ;;
    submodules)
        git submodule foreach "git push prod; git push"
        ;;
    *)
        echo "Error: The parameter must be 'prod', 'staging', or 'submodules'"
        exit 1
        ;;
esac
