DOCKER_IMAGE_NAME ?= easyevent:latest
DOCKER_WORK_DIR ?= /opt/src
DOCKER_RUN ?= docker run --rm -it --user "$(shell id -u):$(shell id -g)" -v ${CURDIR}:${DOCKER_WORK_DIR}


build:
	docker build -t ${DOCKER_IMAGE_NAME} ${BUILD_ARGS} --build-arg DOCKER_WORK_DIR=${DOCKER_WORK_DIR} .

rebuild:BUILD_ARGS = --no-cache
rebuild:build

push:
	docker push ${DOCKER_IMAGE_NAME}

pull:
	docker pull --quiet ${DOCKER_IMAGE_NAME}

shell:
	${DOCKER_RUN} ${DOCKER_IMAGE_NAME} /bin/bash

lint:
	${DOCKER_RUN} ${DOCKER_IMAGE_NAME} make lint_local

lint_local:
	flake8 .

typing:
	${DOCKER_RUN} ${DOCKER_IMAGE_NAME} make typing_local

typing_local:
	mypy easyevent

deadcode:
	${DOCKER_RUN} ${DOCKER_IMAGE_NAME} make deadcode_local

deadcode_local:
	vulture --min-confidence 90 easyevent tests

test:
	${DOCKER_RUN} -e "PYTEST_ARGS=${PYTEST_ARGS}" ${DOCKER_IMAGE_NAME} make test_local

test_local:PYTEST_ARGS := $(or ${PYTEST_ARGS},--cov --no-cov-on-fail --junitxml=report.xml --cov-report xml --cov-report term --cov-report html)
test_local:
	pytest ${PYTEST_ARGS}

list_installed_files:
	${DOCKER_RUN} ${DOCKER_IMAGE_NAME} make list_installed_files_local

list_installed_files_local:
	# List files installed by the Python package
	make clean
	python3 -m venv /tmp/venv --system-site-packages
	cp -a ${DOCKER_WORK_DIR} /tmp/src
	cd /tmp/src && /tmp/venv/bin/pip install .
	cd /tmp/src && /tmp/venv/bin/pip show -f easyevent

clean:
	rm -rf .coverage .pytest_cache .local .eggs build dist *.egg-info
	find . -type f -name *.pyc -delete
	find . -type d -name __pycache__ -delete
