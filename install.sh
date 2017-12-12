#!/bin/bash

set -u
cd $(cd $(dirname $0); pwd)

echo "start setup..."
for f in .??*; do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitmodules" ] && continue
  [ "$f" = "README.md" ] && continue
  [ "$f" = "LICENSE" ] && continue

  if [ $# -ne 1 ]; then
    ln -snfv ~/dotfiles/"$f" ~/
  else
    ln -snfv $1/dotfiles/"$f" $1/
  fi
done

cat << END

**************************************************
complete setup!
**************************************************

END
