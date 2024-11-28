#!/bin/bash

base_url="git@gitlab.iiit.ac.in:slc-tech-team"

export base_url

git submodule foreach '
  submodule_name=$(basename "$name")

  if [ "$submodule_name" = "files" ]; then
    echo "Skipping files submodule."
    exit 0
  fi

  # Determine the URL based on the submodule name (only the last part of the path)
  url="$base_url/$submodule_name.git"

  # Only proceed if there is a defined URL for gitlab
  if [ -n "$url" ]; then
    # Check if gitlab remote already exists
    if ! git remote | grep -q "^gitlab$"; then
      git remote add gitlab "$url"
      echo "Added gitlab remote for $sm_path: $url"
    else
      echo "Gitlab remote already exists for $sm_path."
    fi
  else
    echo "No gitlab URL specified for $sm_path."
  fi
'

echo "Entering base repository 'services'"

# Add remote to base repository
if ! git remote | grep -q "^gitlab$"; then
  git remote add gitlab "$base_url/services.git"
  echo "Added gitlab remote for services: $base_url/services.git"
else
  echo "Gitlab remote already exists for services."
fi
