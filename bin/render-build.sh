#!/usr/bin/env bash
# exit on error
set -o errexit
chmod a+x bin/render-build.sh

bundle install
./bin/rails assets:precompile
./bin/rails assets:clean