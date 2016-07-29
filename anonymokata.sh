#!/bin/bash

CURRENT_DIR="$(dirname "$0")"
source $CURRENT_DIR/functions.sh

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
read -a NAME
NAME=${NAME:-$UUID}
echo ""

# github repository
echo -n "Enter the GitHub URL to clone : "
read -a REPOSITORY
REPOSITORY=${REPOSITORY:-Q}
echo ""

if [ ${REPOSITORY[0]} = "Q" ] || [ ${REPOSITORY[0]} = "q" ]; then
  exit 0
fi

echo -n "Do you want to anonymize this repo? [Y/n]: "
read confirm
confirm=${confirm:-Y}
echo "$confirm"
	
clone_candidate_repository
create_new_org_repository
if [ $confirm = "Y" ] || [ $confirm = "y" ]; then
	scrub_repo
fi
push_new_repo_to_org
echo "complete."
