#!/bin/bash

OWN=$1
REP=$2
USR=$3

if [ -z "$OWN" -o -z "$REP" ]; then
  echo "usage: create.fork.sh owner repository [user]"
  echo "      (https://github.com/owner/repository"
  echo "      >https://github.com/user/repository)"
  exit 1
fi

# https://developer.github.com/v3/repos/forks/#create-a-fork
# git clone https://github.com/$OWN/$REP && cd $REP
# hub api -X POST /repos/$OWN/$REP/forks
# git remote rename origin upstream
# git remote add -f origin https://github.com/$USR/$REP
# or instead:
hub clone $OWN/$REP && cd $REP
hub fork --remote-name=origin

# IMPORTANT: Never push to upstream master
git remote set-url --push upstream no_push
git remote -v

git branch -u origin/master
git branch -a

# enforce rebasing instead of merging
git config branch.autoSetupRebase always
