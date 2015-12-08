.PHONY: clean clean-build clean-pyc clean-test clean-docs lint test test-all coverage coverage docs servedocs release dist install register requirements

help:
	@echo "clean			remove all build, test, coverage and Python artifacts"
	@echo "clean-build		remove build artifacts"
	@echo "clean-pyc		remove Python file artifacts"
	@echo "clean-test		remove test and coverage artifacts"
	@echo "lint				check style with flake8"
	@echo "test				run tests quickly with the default Python"
	@echo "test-all			run tests on every Python version with tox"
	@echo "dist				package"
	@echo "install			install the package to the active Python's site-packages"
	@echo "register			update pypi"
	@echo "requirements		update and install requirements"

clean: clean-build clean-pyc clean-test

clean-build:
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -fr {} +

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test:
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/

lint:
	flake8 sample_module tests

test: lint
	python setup.py test

test-all: lint
	tox

coverage:
	coverage run --source sample_module setup.py test
	coverage report -m
	coverage html
	$(BROWSER) htmlcov/index.html
	$(MAKE) -C docs coverage


dist: clean docs
	python setup.py sdist
	python setup.py bdist_wheel
	ls -l dist

install: clean
	python setup.py install

requirements:
	pip install --quiet pip-tools
	pip-compile requirements_dev.in > /dev/null
	pip-compile requirements.in > /dev/null
	pip-sync requirements_dev.txt > /dev/null
	pip install --quiet -r requirements.txt
	pip wheel --quiet -r requirements_dev.txt
	pip wheel --quiet -r requirements.txt
	git diff --word-diff requirements.txt requirements_dev.txt &> .requirements.diff
