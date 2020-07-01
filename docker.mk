.PHONY: help install dependencies build bash clean

NAME := tamakiii-sandbox/hello-newrelic

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	build

dependencies:
	type docker > /dev/null

build:
	docker build -t $(NAME) .

bash:
	docker run -it --rm $(NAME) $@

clean:
	docker image rm $(NAME)
