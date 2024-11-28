#!/bin/bash

prod_url_auth="git@clubs.iiit.ac.in:auth.git"
prod_url_files="git@clubs.iiit.ac.in:files.git"
prod_url_gateway="git@clubs.iiit.ac.in:gateway.git"
prod_url_clubs="git@clubs.iiit.ac.in:clubs.git"
prod_url_events="git@clubs.iiit.ac.in:events.git"
prod_url_interfaces="git@clubs.iiit.ac.in:interfaces.git"
prod_url_members="git@clubs.iiit.ac.in:members.git"
prod_url_users="git@clubs.iiit.ac.in:users.git"
prod_url_web="git@clubs.iiit.ac.in:web.git"
prod_url_services="git@clubs.iiit.ac.in:services.git"

# Export URLs as environment variables for access within submodule foreach
export prod_url_auth prod_url_files prod_url_gateway prod_url_clubs
export prod_url_events prod_url_interfaces prod_url_members prod_url_users prod_url_web

git submodule foreach '
  if [ "$name" = "apis/auth-dev" ]; then
    echo "Skipping auth-dev submodule."
    exit 0
  fi

  # Determine the URL based on the submodule path
  case "$sm_path" in
    "apis/auth") url="$prod_url_auth" ;;
    "apis/files") url="$prod_url_files" ;;
    "gateway") url="$prod_url_gateway" ;;
    "subgraphs/clubs") url="$prod_url_clubs" ;;
    "subgraphs/events") url="$prod_url_events" ;;
    "subgraphs/interfaces") url="$prod_url_interfaces" ;;
    "subgraphs/members") url="$prod_url_members" ;;
    "subgraphs/users") url="$prod_url_users" ;;
    "web") url="$prod_url_web" ;;
    *) url="" ;;
  esac

  # Only proceed if there is a defined URL for prod
  if [ -n "$url" ]; then
    # Check if prod remote already exists
    if ! git remote | grep -q "^prod$"; then
      git remote add prod "$url"
      echo "Added prod remote for $sm_path: $url"
    else
      echo "Prod remote already exists for $sm_path."
    fi
  else
    echo "No prod URL specified for $sm_path."
  fi
'

echo "Entering base repository 'services'"

# Add remote to base repository
if ! git remote | grep -q "^prod$"; then
  git remote add prod "$prod_url_services"
  echo "Added prod remote for services: $prod_url_services"
else
  echo "Prod remote already exists for services."
fi
