#!/bin/bash

function clone_candidate_repository {
	git clone $repository $name
	cd $name
}

function create_new_org_repository {
  # create new repository in organization
  curl -u "$USER" https://api.github.com/orgs/$ORGANIZATION/repos -d '{"'"name"'":"'"$name"'"}'
}

function push_new_repo_to_org {
	# push new repository to organization
	git remote set-url origin https://github.com:/$ORGANIZATION/$name.git
	git push -u origin master
}

function scrub_repo {
	# scrub repository
	git filter-branch --env-filter '
	export GIT_AUTHOR_NAME="anonymous"
	export GIT_COMMITTER_NAME="anonymous"
	export GIT_AUTHOR_EMAIL="anonymous"
	export GIT_COMMITTER_EMAIL="anonymous"
	' -- --all
}
