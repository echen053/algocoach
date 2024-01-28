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

## Load DB data from LLM/ChatGPT
```shell
cd algo_server
make reload_topics
```

## DB setup (Warning! Do NOT do this unless you want to rebuild everything in DB)
```bash
cd algo_server/db

# remove db if needed
rm coach.db

# create db tables
sqlite3 coach.db < create_tables.sql
```