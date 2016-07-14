#!/bin/bash

USER=ddaugher
ORGANIZATION=anonymokata

curl -u "$USER" https://api.github.com/orgs/$ORGANIZATION/repos -d '{"'"name"'":"'"$1"'"}'
git remote set-url origin https://github.com:/$ORGANIZATION/$1.git
git push -u origin master

#git filter-branch --env-filter '
#export GIT_AUTHOR_EMAIL="anonymous"
#export GIT_AUTHOR_NAME="anonymous"
#' -- --all

