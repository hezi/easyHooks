#!/bin/bash


# get all relevant staged files and run clang-format to check formatting
files=()
for file in `git diff --cached --name-only --diff-filter=ACMRT | grep -E "\.(m|h)$"`; do
  if ! (clang-format ${file} | cmp ${file} -s -) then
    files+=("${file}")
  fi
done

# print the names of files not formatted correctly 
if [ -n "${files}" ]; then
  echo Format error within the following files:
  printf "%s\n" "${files[@]}"
  exit 1
fi