SHELL := /bin/bash

start:
	OPEN_AI_API_KEY=$$OPEN_AI_API_KEY \
	LANGCHAIN_HANDLER=langchain \
	poetry run jupyter notebook --ip='*' --NotebookApp.token='' --NotebookApp.password=''

install: pyproject.toml
	poetry install

update:
	poetry update langchain

server:
	PYTHONPATH=./src uvicorn main:app --reload

python:
	poetry run python

clean:
	poetry env remove python

clean-cache:
	poetry cache clear --all pypi
