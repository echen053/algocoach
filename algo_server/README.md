# AlgoCoach Server

## Install Python, poetry, PyCharm

## Setup projects
```
poetry install
brew install sqlite
```

## Run Server
```commandline
make server
```

## DB setup
```bash
sqlite3 coach.db < create_tables.sql
sqlite3 coach.db < topics_data.sql
```