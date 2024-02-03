#!/usr/bin/env bash
# exit on error
set -o errexit

chmod +x ./bin/rails  # Add this line to set execute permissions for ./bin/rails

bundle install
./bin/rails assets:precompile
./bin/rails assets:clean
