ifneq ("$(wildcard .env)","")
	include .env
	export
endif

.PHONY: install
install: ## Install Python requirements.
	python -m pip install --upgrade pip setuptools wheel poetry
	poetry lock
	poetry install --no-root
	poetry run pre-commit install

.PHONY: run
run: ## Run the project.
	poetry run python -m src.app

.PHONY: run-example-script
run-example-script: ## Run first example script.
	poetry run python src/scripts/example_xyz.py

.PHONY: run-env-var-usage-example-script
run-env-var-example-script: ## Run environment variables usage example script.
	poetry run python src/scripts/example_env.py

.PHONY: notebook
notebook: ## Start Jupyter Notebook.
	poetry run jupyter notebook --notebook-dir=src/notebooks/ --browser='open %s'

.PHONY: pre-commit
pre-commit: ## Run pre-commit checks.
	poetry run pre-commit run --config ./.pre-commit-config.yaml

.PHONY: patch
patch: ## Bump project version to next patch (bugfix release/chores).
	poetry version patch

.PHONY: minor
minor: ## Bump project version to next minor (feature release).
	poetry version minor

.PHONY: clean-notebooks
clean-notebooks: ## Clean Jupyter Notebooks of output data.
	find . -name '*.ipynb' | xargs -P 6 -n 1 poetry run python -m jupyter nbconvert --clear-output --inplace

.PHONY: clean
clean: ## Clean project's temporary files.
	find . -wholename '*/.ipynb_checkpoints' -exec rm -rf {} +
	find . -name '__pycache__' -exec rm -rf {} +
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.log' -exec rm -f {} +

.DEFAULT_GOAL := help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed 's/Makefile://g' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
