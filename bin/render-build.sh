#!/usr/bin/env bash

# exit on error
set -o errexit

bundle install
rails db:migrate db:seed # if needed
