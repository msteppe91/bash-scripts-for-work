#!/bin/sh
# from: https://help.github.com/en/github/using-git/changing-author-info

git filter-branch --env-filter '

OLD_EMAIL="email@example.com"
CORRECT_NAME="Author Name"
CORRECT_EMAIL="new_email@example.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
export GIT_COMMITTER_NAME="$CORRECT_NAME"
export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
export GIT_AUTHOR_NAME="$CORRECT_NAME"
export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
