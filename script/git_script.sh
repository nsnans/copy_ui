#!/bin/bash
git add .
git commit -m "$1"
git push

# 运行：in git Brsh
# ./script/git_script.sh 'fix'