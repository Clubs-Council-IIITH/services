#!/bin/bash

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 [setup|prod|staging|submodules|github]"
    exit 1
fi

case "$1" in
    setup)
        chmod +x .scripts/deploy-setup.sh
        ./.scripts/deploy-setup.sh
        ;;
    prod)
        git push prod master:prod
        ;;
    staging)
        git push prod master:staging
        ;;
    submodules)
        git submodule foreach "git push prod master"
        ;;
    github)
        git submodule foreach "git push origin master"
        git push origin master
        ;;
    *)
        echo "Error: The parameter must be 'prod', 'staging', 'github', or 'submodules'"
        exit 1
        ;;
esac
