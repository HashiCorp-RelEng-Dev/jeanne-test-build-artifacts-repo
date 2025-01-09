#!/bin/bash
set -euo pipefail

dir=$1

# set matrix var to list of file names in a given directory
matrix="$(find "$dir" -mindepth 1 -maxdepth 1 -printf "%P\n" | jq --slurp --compact-output --raw-input 'split("\n")[:-1]')"

echo "matrix=${matrix}" | tee -a "${GITHUB_OUTPUT}"