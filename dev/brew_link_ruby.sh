#! /bin/bash
if [ -z "$(uname -a | grep Linux)" ]; then
  exit
fi

pushd "$(mktemp -d)" 2>/dev/null || exit 1
list="$(brew link --overwrite --dry-run ruby | grep -v 'Would remove:')"
[ -z "$list" ] && brew link ruby && exit 0

/bin/mv $list .
brew link ruby
for f in $(/bin/ls -1); do
  mv "$f" "$(brew --prefix)/bin/"
done

