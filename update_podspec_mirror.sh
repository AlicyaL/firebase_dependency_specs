#!/bin/bash

set -euo pipefail
set -x

REPOS_LOCATION="/tmp/cocoapods"
MASTER_REPO_LOCATION="$REPOS_LOCATION/master"

tempfile=$(mktemp)

cleanup() {
  echo "Download failed, cleaning up and falling back to standard checkout..."
  rm -rf "$MASTER_REPO_LOCATION"
  rm "$tempfile"
  exit 1
}

# trap cleanup ERR

# rm -rf "$MASTER_REPO_LOCATION"
# mkdir -p "$REPOS_LOCATION"

# echo "Downloading CocoaPods master repo..."
# curl -L https://github.com/CocoaPods/Specs/archive/master.tar.gz -o "$tempfile"

# echo "Uncompressing CocoaPods master repo..."
# # We expect the structure with the "master" as the top dir in the archive.
# tar -C "$REPOS_LOCATION" -xzf "$tempfile"
# mv "$REPOS_LOCATION/Specs-master" "$MASTER_REPO_LOCATION"

# echo "Successfully downloaded CocoaPods master repo."
# rm "$tempfile"

#Then we copy over the specs we needed into our own repo

#!/bin/bash

mkdir -p Specs

while read -r pod
do
  spec_dir="$(find /tmp/cocoapods/master -type d -name "$pod")"
  if [ -n "$spec_dir" ]; then
    output_path="Specs/$pod"
    echo "Copying specs from '$spec_dir' to '$output_path'"
    cp -R "$spec_dir" "$output_path"
  else
    echo "No specs found for '$pod'"
  fi
done < "pods.txt"