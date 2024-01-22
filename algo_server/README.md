# AlgoCoach Server

## Install Python, poetry, PyCharm

## Setup projects
```
poetry install
brew install sqlite
```

## To start the Server
```bash
make server  # CTRL-C to stop it.
```

## DB setup
```bash
cd algo_server/db

# remove db if needed
rm coach.db

# create db tables
sqlite3 coach.db < create_tables.sql

# load topic data
sqlite3 coach.db < topics_data.sql
```