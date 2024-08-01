#!/bin/sh

# terminate if any command exits with a non-zero status
set -e

echo "Bundling gems"
bundle install

echo "Recreating database..."
bundle exec rails db:drop
bundle exec rails db:create

echo "Running migrations..."
bundle exec rails db:migrate

echo "Seeding database..."
bundle exec rails db:seed

bundle exec rake db:prepare

# Thanks random homie from stackoverflow
# https://stackoverflow.com/questions/77287655/how-to-solve-docker-container-exec-format-error-for-running-entrypoint
exec "$@"
