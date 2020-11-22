SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

BUILDER="gcr.io/buildpacks/builder:v1"
REPO_NAME="ghcr.io/bobcatprogrammer
IMAGE_NAME="skeleton-fastapi"
APP_DIR="app"


# Default Build
.PHONY: build
build: ## Build the container image using pack CLI
>  docker build . -t $(REPO_NAME)/$(IMAGE_NAME)

.DEFAULT_GOAL := build

.PHONY: run
run: build ## Run container local
> docker run --rm -it -p 8000:8000 $(REPO_NAME)/$(IMAGE_NAME)

.PHONY: lint
lint: export PIPENV_VERBOSITY=-1
lint: isort black flake8 mypy

.PHONY: mypy
mypy:
> pipenv run mypy

.PHONY: flake8
flake8:
> pipenv run flake8

.PHONY: black
black:
> pipenv run black .

.PHONY: isort
isort:
> pipenv run isort .


.PHONY: test
test: export PIPENV_VERBOSITY=-1
test:
> pipenv run pytest --cov --cov-fail-under=100
