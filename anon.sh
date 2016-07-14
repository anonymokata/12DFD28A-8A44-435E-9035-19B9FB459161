#!/bin/bash

current_dir="$(dirname "$0")"
source $current_dir/functions.sh

# determine name of organization 
echo -n "Enter the name of the organization. [anonymokata] : "
read -a ORGANIZATION
ORGANIZATION=${ORGANIZATION:-anonymokata}
echo ""

# determine name of user 
echo -n "Enter the name of the user within $ORGANIZATION. [ddaugher] : "
read -a USER
USER=${USER:-ddaugher}
echo ""

# determine name of new repository
UUID=$(uuidgen)
echo -n "Enter the name of the new repository. ["$UUID"] : "
read -a name
name=${name:-$UUID}
echo ""

# github repository
echo -n "Enter the GitHub URL to clone : "
read -a repository
repository=${repository:-Q}
echo ""

if [ ${repository[0]} = "Q" ] || [ ${repository[0]} = "q" ]; then
  exit 0
fi

echo -n "Do you really want to anonymize this repo? [Y/n]: "
read confirm
confirm=${confirm:-Y}
echo "$confirm"

if [ $confirm = "Y" ] || [ $confirm = "y" ]; then
	clone_candidate_repository
	create_new_org_repository
	scrub_repo
	push_new_repo_to_org
    echo "complete."
fi
