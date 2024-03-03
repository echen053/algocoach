SHELL := /bin/bash

start_jupyter:
	OPEN_AI_API_KEY=$$OPEN_AI_API_KEY \
	LANGCHAIN_HANDLER=langchain \
	poetry run jupyter notebook --ip='*' --NotebookApp.token='' --NotebookApp.password=''

install: pyproject.toml
	poetry lock
	poetry install

update:
	poetry update langchain

start_server:
	PYTHONPATH=./src uvicorn server:app --reload

reload_topics:
	PYTHONPATH=./src poetry run python src/tool/load_topics.py --dbfile "db/coach.db" --topicfile "src/tool/topic_data_all.json"

python:
	poetry run python

clean:
	rm -rf .venv

clean-cache:
	poetry cache clear --all pypi
