.PHONY: help install dependencies build bash clean

NAME := tamakiii-sandbox/hello-newrelic
WORKDIR := /usr/local/app/hello-newrelic
OPTIONS :=

NEWRELIC_LICENSE_KEY ?= $(shell grep 'NEWRELIC_LICENSE_KEY' .env | awk -F= '{ print $$2 }')
BUILD_ARGS ?= NEWRELIC_LICENSE_KEY=$(NEWRELIC_LICENSE_KEY)
VOLUMES := $(CURDIR):$(WORKDIR)

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	.env \
	build

dependencies:
	type docker > /dev/null

.env:
	echo "NEWRELIC_LICENSE_KEY=$(NEWRELIC_LICENSE_KEY)" > $@

build:
	docker build -t $(NAME) $(foreach a,$(BUILD_ARGS),--build-arg $a) $(OPTIONS) .

bash:
	docker run -it --rm  -w $(WORKDIR) $(foreach v,$(VOLUMES),-v $v) $(NAME) $@

clean:
	docker image rm $(NAME)
