#!/bin/sh

# terminate if any command exits with a non-zero status
set -e

echo "Bundling gems"
bundle install

echo "Creating database"
bundle exec rails db:create

echo "Running Migrations"
bundle exec rails db:migrate

echo "Seeding database"
bundle exec rails db:seed

# Thanks random homie from stackoverflow
# https://stackoverflow.com/questions/77287655/how-to-solve-docker-container-exec-format-error-for-running-entrypoint
exec "$@"
