
echo "Bundling gems"
bundle install

echo "Creating database"
bundle exec rails db:create

echo "Running Migrations"
bundle exec rails db:migrate

echo "Seeding database"
bundle exec rails db:seed
