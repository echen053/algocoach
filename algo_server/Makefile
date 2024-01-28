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
	PYTHONPATH=./src uvicorn main:app --reload

python:
	poetry run python

clean:
	rm -rf .venv

clean-cache:
	poetry cache clear --all pypi
