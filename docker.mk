.PHONY: help install dependencies build clean

NEWRELIC_LICENSE_KEY :=
HTTP_PORT := 8080
OPTIONS :=

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
	echo "HTTP_PORT=$(HTTP_PORT)" >> $@

build:
	docker-compose build $(OPTIONS)

clean:
	docker-comose down -v
