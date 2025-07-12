#! /usr/bin/bash

# Exit Immediately if a command fails
set -e

GITHUB_ENV=$(readlink -f "$GITHUB_ENV")

cd "$(dirname "$0")"

DISTRO="${DISTRO:-unstable}"
MAINTAINER=$(git log -1 --pretty=format:'%an <%ae>')
VERSION=$(cat ../VERSION | cut -d'v' -f2)
REVISION=${REVISION:-0}

echo "VERSION=$VERSION" >>"$GITHUB_ENV"
echo "DATE=$(date -u +'%Y%m%d')" >>"$GITHUB_ENV"

# Gen changelog (from latest commit)
MSG=$(git log -1 --pretty=format:'%s')
DATE=$(git log -1 --pretty=format:'%ad' --date=format:'%a, %d %b %Y %H:%M:%S %z')

# Generate changelog
cat <<EOF >changelog
calamares-settings-blissos ($VERSION-$REVISION) $DISTRO; urgency=medium

$(echo -e "$MSG" | sed -r 's/^/  * /g')

 -- $MAINTAINER  $DATE

EOF
