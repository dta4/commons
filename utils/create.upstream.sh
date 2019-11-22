#!/bin/bash

OWN=$1
REP=$2

if [ -z "$OWN" -o -z "$REP" ]; then
  echo "usage: create.upstream.sh owner repository"
  echo "      (https://github.com/owner/repository)"
  exit 1
fi

mkdir $REP && cd $REP && touch .gitkeep

git init
git add . && git commit -m "It begins."
git branch stable master

# https://developer.github.com/v3/repos/#create
# hub api /orgs/$OWN/repos -F name=$REP
# git remote add -f origin https://github.com/$OWN/$REP
# or instead:
hub create $OWN/$REP

git push origin --all
cd .. && rm -Rf $REP

# https://developer.github.com/v3/repos/#edit
cat <<EOT | hub api /repos/$OWN/$REP -XPATCH --input -
{
  "private": false,
  "allow_merge_commit": false,
  "allow_rebase_merge": false
}
EOT
