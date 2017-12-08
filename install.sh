#!/bin/bash

set -u
cd $(cd $(dirname $0); pwd)

echo "start setup..."
for f in .??*; do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitmodules" ] && continue

  ln -snfv ~/dotfiles/"$f" ~/
done

cat << END

**************************************************
complete setup!
**************************************************

END
