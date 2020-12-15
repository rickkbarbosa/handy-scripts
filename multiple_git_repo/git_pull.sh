#!/bin/bash
#Perform git pull once per remote-url present
GIT_BRANCH=$(git branch --show-current;)
for GIT_REMOTE in $(git remote show); do git pull ${GIT_REMOTE} ${GIT_BRANCH}; done
