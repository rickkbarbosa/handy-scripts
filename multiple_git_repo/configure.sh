#!/bin/bash
#Configure git repo to push two or more different repositories

GITREPO[1]="git@some-url-or-not:my-repository.git"
GITREPO[2]="git@some-url-or-not:my-another-repository.git"


for GIT_REMOTE in ${GITREPO[@]} ; do
	git remote set-url all -push -add

	REMOTE_BASE_URL=$(echo $GIT_REMOTE | cut -d ':' -f 1 | cut -d '@' -f 2;)
	git config -–add remote.all.url	${REMOTE_BASE_URL}
done