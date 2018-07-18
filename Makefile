DOCKER_COMPOSE  = docker-compose

##
## To start the project, you juste have to use the command `make init`.
## The reverse-proxy will be started every time you start your pc :)
##
## Note : if you need, for one reason or another, start or stop the
## proxy, you can use `make start` and `make stop`.
##
## Enjoy !
##

install:
	git clone https://github.com/containous/traefik

init-compose:
	cp docker-compose.yml traefik/docker-compose.yml

init: install init-compose ## Init the project by installing dependencies and start it (must be done one time).
	cd traefik; $(DOCKER_COMPOSE) up -d

start: ## Start the project
	$(DOCKER_COMPOSE) up -d --remove-orphans --no-recreate

stop: ## Stop the project
	$(DOCKER_COMPOSE) stop

.PHONY: install init-compose init start stop

.DEFAULT_GOAL := help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
.PHONY: help
