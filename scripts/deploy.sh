#!/bin/bash
set -e

REPO=$(git config remote.origin.url)

echo $TRAVIS_BRANCH
echo $DEPLOY_BRANCH
echo $TRAVIS_PULL_REQUEST

if [ "$TRAVIS_BRANCH" != "$DEPLOY_BRANCH" ]; then
	exit 1
else
	if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
		echo "Travis doesn't deploy from pull requests"
		exit 0
	else
		REPO=${REPO/git:\/\/github.com\//git@github.com:}
		REPO=${REPO/https:\/\/github.com\//git@github.com:}

		chmod 600 $SSH_KEY
		eval `ssh-agent -s`
		ssh-add $SSH_KEY
		git config --global user.name "$GIT_NAME"
		git config --global user.email "$GIT_EMAIL"
	fi
fi

REPO_NAME=$(basename $REPO)
TARGET_DIR=$(mktemp -d /tmp/$REPO_NAME.XXXX)
REV=$(git rev-parse HEAD)
git clone --branch ${TARGET_BRANCH} ${REPO} ${TARGET_DIR}
rsync -rt --delete --exclude=".git" --exclude=".travis.yml" $SOURCE_DIR/ $TARGET_DIR/
cd $TARGET_DIR
git add -A .
git commit --allow-empty -m "Built from commit $REV"
git push $REPO $TARGET_BRANCH

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
