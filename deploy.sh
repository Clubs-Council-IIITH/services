#!/bin/bash

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 [setup|prod|staging|submodules|github|gitlab]"
    exit 1
fi

case "$1" in
    setup)
        chmod +x .scripts/deploy-setup.sh
        chmod +x .scripts/gitlab-setup.sh
        echo $'\nSetting up deploy remotes...'
        ./.scripts/deploy-setup.sh
        echo $'\nSetting up gitlab remotes...'
        ./.scripts/gitlab-setup.sh
        ;;
    prod)
        git push prod master:prod
        ;;
    staging)
        git push prod master:staging
        ;;
    submodules)
        git submodule foreach '[ "$path" = "apis/auth-dev" ] || git push prod master'
        ;;
    github)
        git submodule foreach "git push origin master; git remote prune origin"
        git push origin master; git remote prune origin
        ;;
    gitlab)
        git submodule foreach '[ "$path" = "apis/files" ] || git push gitlab master'
        git push gitlab master
        ;;
    *)
        echo "Error: The parameter must be 'setup', 'prod', 'staging', 'github', or 'submodules'"
        exit 1
        ;;
esac
