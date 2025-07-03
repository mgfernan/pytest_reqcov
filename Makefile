.PHONY: help install install-dev test build upload-test upload

install:
	pip install .

install-dev:
	pip install -e .[dev]

test:
	pytest -q --reqcov-reqs=tests/sample/requirements.csv  \
	       --reqcov-prods=tests/sample/products.csv \
		   --reqcov-output=output.csv tests/|| true
	diff output.csv tests/sample/output.csv

build: clean
	python -m build

upload-test: build
	twine upload --repository testpypi dist/*

upload: build
	twine upload dist/*
