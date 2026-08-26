#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
set -vx

bundle install

# Do any other automated setup that you need to do here

mkdir %USERPROFILE%/.kozbot
cd %USERPROFILE%/.kozbot
mkdir media_cache
mkdir chat
echo '' > config.yaml
