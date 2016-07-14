#!/bin/bash

# determine name of organization 
echo -n "Enter the name of the organization. (enter Q to quit): "
read -a ORGANIZATION
remove=${ORGANIZATION:-anonymokata}
echo ""

if [ ${ORGANIZATION[0]} = "Q" ] || [ ${ORGANIZATION[0]} = "q" ]; then
  exit 0
fi

# determine name of user 
echo -n "Enter the name of the user within $ORGANIZATION. (enter Q to quit): "
read -a USER
remove=${USER:-Q}
echo ""

if [ ${USER[0]} = "Q" ] || [ ${USER[0]} = "q" ]; then
  exit 0
fi

# determine name of new repository
echo -n "Enter the name of the new repository. (enter Q to quit): "
read -a name
remove=${name:-Q}
echo ""

if [ ${name[0]} = "Q" ] || [ ${name[0]} = "q" ]; then
  exit 0
fi

# clone repository
echo -n "Enter the repository URL to clone. (enter Q to quit): "
read -a repository
remove=${repository:-Q}
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
