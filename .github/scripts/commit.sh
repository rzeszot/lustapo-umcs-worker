#!/bin/sh

cd data

git init
git remote add origin git@upstream:rzeszot/lustapo-data.git
git config user.name 'Igor'
git config user.email 'igor.bot@users.noreply.github.com'

git add -A
git commit -m "[UMCS] `date +"%F %H:%M"`"

git push origin HEAD:umcs-`date +"%F-%H-%M"`
