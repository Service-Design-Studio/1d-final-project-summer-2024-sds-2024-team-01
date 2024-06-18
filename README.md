# To setup database for local development
- Ensure postgresql + postgis is installed
  - https://postgis.net/documentation/getting_started/#installing-postgis
  - https://www.postgresql.org/download/

## Install PostgreSQL (For windows)

Download the installer here: https://www.enterprisedb.com/downloads/postgres-postgresql-downloads

<br/>

1. Run the installer

![image](https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-01/assets/41722713/308ac7cf-2b56-4e5d-b51a-89a8230a226d)

<br/>

2. At this step, check EVERYTHING <b>INCLUDING</b> STACK BUILDER

![image](https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-01/assets/41722713/ec10ea43-a7e6-458c-a0bb-e49f177ef102)

<br/>

3. REMEMBER YOUR PASSWORD AT THIS STEP

![image](https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-01/assets/41722713/4b2f7feb-f6d3-4637-90f2-340e9dd6b21e)

4. Updated your database.yml with the password you entered at the previous step 
5. After installation, run stack builder
6. Under spatial extensions, install PostGIS


## Migrating and data setup

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
