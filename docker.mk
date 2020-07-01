.PHONY: help install dependencies build bash clean

NAME := tamakiii-sandbox/hello-newrelic
OPTIONS :=

NEWRELIC_LICENSE_KEY :=
HTTP_PORT := 8080

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

bash:
	docker run -it --rm  -w $(WORKDIR) $(foreach v,$(VOLUMES),-v $v) $(NAME) $@

clean:
	docker image rm $(NAME)
