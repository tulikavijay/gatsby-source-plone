SHELL := /bin/bash
CURRENT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all: clean build test

clean:
	@echo "Clean"
	rm -rf .py27

build:
	@echo "Build"
	virtualenv-2.7 .py27 || virtualenv .py27
	.py27/bin/pip install -r requirements.txt

test:
	@echo "Run Tests"
	yarn install
	(cd tests/gatsby-starter-default && yarn install)
	(cd tests/gatsby-starter-default && gatsby develop &)
	sleep 10
	pybot test.robot
