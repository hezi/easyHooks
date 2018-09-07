#!/bin/bash
declare -a all_hooks=("applypatch-msg" 
  "pre-applypatch" 
  "post-applypatch" 
  "pre-commit" 
  "prepare-commit-msg" 
  "commit-msg" 
  "post-commit" 
  "pre-rebase" 
  "post-checkout" 
  "post-merge" 
  "pre-push" 
  "pre-receive" 
  "update" 
  "post-receive" 
  "post-update" 
  "push-to-checkout" 
  "pre-auto-gc" 
  "post-rewrite" 
"sendemail-validate")

# get repos base path
base_git=`git rev-parse --show-toplevel`

for current_hook in "${all_hooks[@]}"
do
  # copy base-hook to current_hook
  cp "$base_git/scripts/base-hook" "$base_git/.git/hooks/$current_hook"

  # modify base-hook template to represent current_hook
  sed -i -e "s/base-hook/$current_hook/" "$base_git/.git/hooks/$current_hook"

  # remove leftover
  rm "$base_git/.git/hooks/$current_hook-e"
done