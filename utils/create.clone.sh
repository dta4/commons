#!/bin/bash

OWN=$1
REP=$2

if [ -z "$OWN" -o -z "$REP" ]; then
  echo "usage: create.clone.sh owner repository user"
  echo "      (https://github.com/owner/repository"
  echo "      >https://github.com/user/repository)"
  exit 1
fi

git clone https://github.com/$OWN/$REP && cd $REP
git remote rename origin upstream
hub remote add origin

# IMPORTANT: Never push to upstream master
git remote set-url --push upstream no_push
git remote -v

git fetch origin
git branch -u origin/master
git branch -a

git fetch upstream
git rebase upstream/master

# enforce rebasing instead of merging
git config branch.autoSetupRebase always
