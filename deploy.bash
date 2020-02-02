#!/bin/bash

WEB_DIR="/group_projects/cs4760/s20/group2/www/"
ASSET_DIR="${WEB_DIR}../deploy_assets/"
GROUP="cs4760.2"

source "/group_projects/cs4760/s20/group2/renv/activate"

# Functions

is_in_group()
{
  groupname="$1"
  # The second argument is optional -- defaults to current user.
  current_user="$(id -un)"
  user="${2:-$current_user}"
  for group in $(id -Gn "$user") ; do
    if [ "$group" = "$groupname" ]; then
      return 0
    fi
  done
  # If it reaches this point, the user is not in the group.
  return 1
}


INT_deploy()
{
  # NFS priority dumbness fix
  echo "Clearing old assets"
  chmod 777 -R "$WEB_DIR" && rm -rf "$WEB_DIR"
  mkdir -p "$WEB_DIR"
  # Ruby checks
  echo "Ensuring Ruby modules are installed"
  if [[ ! -d "$ASSET_DIR" ]]
  then
    echo "Asset Directory [${ASSET_DIR}] not found, exiting..."
    exit 1
  fi
  cd "$ASSET_DIR" && bundle install
  echo "Compiling and deploying assets"
  JEKYLL_ENV=production bundle exec jekyll build --destination "$WEB_DIR"
  echo "Resetting file permissions"
  chmod 775 -R "$WEB_DIR"
  chown -R "${USER}:${GROUP}" "$WEB_DIR"
}

# Enforce group perms
if is_in_group "$GROUP" "$USER";
then
  echo "Deploying..."
  INT_deploy
else
  echo "Permission Denied."
fi
#


