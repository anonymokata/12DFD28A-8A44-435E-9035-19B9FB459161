#!/bin/bash

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

# clone repository
echo -n "Enter the candidate repository URL to clone : "
read -a repository
repository=${repository:-Q}
echo ""

if [ ${repository[0]} = "Q" ] || [ ${repository[0]} = "q" ]; then
  exit 0
fi
git clone $repository $name
cd $name

# create new repository in organization
curl -u "$USER" https://api.github.com/orgs/$ORGANIZATION/repos -d '{"'"name"'":"'"$name"'"}'

# scrub repository
git filter-branch --env-filter '
export GIT_AUTHOR_NAME="anonymous"
export GIT_COMMITTER_NAME="anonymous"
export GIT_AUTHOR_EMAIL="anonymous"
export GIT_COMMITTER_EMAIL="anonymous"
' -- --all

# push new repository to organization
git remote set-url origin https://github.com:/$ORGANIZATION/$name.git
git push -u origin master
