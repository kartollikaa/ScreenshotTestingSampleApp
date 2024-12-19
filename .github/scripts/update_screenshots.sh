#!/bin/bash

if [[ -z ${GITHUB_TOKEN} ]]; then
  echo "Missing GITHUB_TOKEN variable"
  exit 1
  fi
  if [[ -z ${GITHUB_REPOSITORY} ]]; then
  echo "Missing GITHUB_REPOSITORY variable"
  exit 1
  fi
  if [[ -z ${PULL_REQUEST_BRANCH} ]]; then
  echo "Missing PR_BRANCH variable"
  exit 1
  fi
  ./gradlew recordRoborazziDebug
  PULL_REQUEST_NUMBER=${GITHUB_REF#refs/pull/}
  PULL_REQUEST_NUMBER=${PULL_REQUEST_NUMBER/\/merge/}
  NEW_BRANCH_NAME="screenshots/pr-$PULL_REQUEST_NUMBER"
  git config --global user.name "roborazzi-screenshot-reporter"
  git config --global user.email "roborazzi-reporter@gmail.com"
  git fetch --all
  git checkout --track "origin/$PULL_REQUEST_BRANCH"
  git checkout -b "$NEW_BRANCH_NAME"
  git add \*.png
  if git diff-index --quiet HEAD --; then
  echo "No changes to commit"
  else
  git commit -m "📸 Update screenshots"
  git push --force "https://$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git"
  fi
  printf -v PULL_REQUEST_URL "https://github.com/%s/compare/%s...%s" "$GITHUB_REPOSITORY" "$PULL_REQUEST_BRANCH" "$NEW_BRANCH_NAME"
  EOF=$(dd if=/dev/urandom bs=15 count=1 status=none | base64)
{
  echo "PULL_REQUEST_NUMBER<<$EOF"
  echo "$PULL_REQUEST_NUMBER"
  echo "$EOF"
  echo "PULL_REQUEST_URL<<$EOF"
  echo "$PULL_REQUEST_URL"
  echo "$EOF"
} >>"$GITHUB_OUTPUT"