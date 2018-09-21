# easyHooks

An easy, simple way to share, install and run git hooks, with no external dependencies. just `./scripts/install_hooks.sh` and edit `hooks.json`

## Intro
Git hooks are a built-in feature of git that allows you to execute scripts before/after certain git events. Git hooks are run locally. Hooks can be used for various tasks: formatting code, running inspections or notifiying remote servers.

All hooks are stored in the `hooks` subdirectory of the Git directory, usually `.git/hooks`.

## The problem
The `.git` is usually a scary hidden place we usually don't interact with, and that's a problem on itself, but the worst part is that anything in the `.git` folder isn't commited to your repo. This is a problem when you want to have a set of hooks in your project, shared by all team members.

## The solution
easyHooks! easyHooks is made up of the following scripts:

1. `./scripts/base-hook` - template script that will run as the hook, once installed. this script looks in `hooks.json` and runs the hooks defined.
2. `./scripts/install_hooks.sh` - installs `base-hook` to the `.git/hooks` directory, one for every git hooks event.
3. `hooks.json` - sits in your repo root directory, defines the hooks to run for every event.

Installation is simple as running `./scripts/install_hooks.sh` and setting your hooks on `hooks.json`
From that point on, your hooks will run, and because everything is in your repo, the files can be commited and share with your team! :tada:

## Example
Let's say you have a script that checks code formatting and prints a list of unformatted files.prevents commits if code isn't formatted:

### `check_format.sh`
```bash
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
```

If we want to prevent a commit if we have unformatted files all we need to do is define our hooks like so:
### `hooks.json`
```json
{
  "pre-commit":"bash ./scripts/check_format.sh"
}
```

Hook installation (`./scripts/install_hooks.sh`) only needs to happen once, after cloning, and from that point on, you only modify and touch `./hooks.json`

SO SIMPLE WOW!

## The sky is the limit!
This is a very simple example, but hooks can be used for anything, from enforcing code styles, to automating task managment (creating tasks from `// TODO` comments :O) and more!