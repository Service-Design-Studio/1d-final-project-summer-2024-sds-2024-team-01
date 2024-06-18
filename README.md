# To setup database for local development
- Ensure postgresql + postgis is installed
  - https://postgis.net/documentation/getting_started/#installing-postgis
  - https://www.postgresql.org/download/

1. Create the necessary databases

```
rails db:create
```

2. Migrate the schema

```
rails db:migrate
```

3. Seed the database with dummy data

```
rails db:seed
```

To reset database after changes
```
rails db:reset
rails db:seed
```

To hard reset database after schema changes
```
rails db:drop
```
Then run steps 1 - 3 again
