include .env
export

NETWORKS="$(shell docker network ls)"
VOLUMES="$(shell docker volume ls)"
SUCCESS=[ done "\xE2\x9C\x94" ]

# default arguments
user ?= admin

.PHONY: traefik
## Run traefik container with docker-compose file in traefik directory
traefik: --traefik-network
	@echo [ starting api... ] && \
	docker compose -f traefik/docker-compose.yml up -d traefik portainer netdata

.PHONY: basic-auth-pwd
## Generate basic auth password and user (default admin) Usage: make -e user=john basic-auth-pwd
basic-auth-pwd:
	@./htpasswd.sh $(user)

.PHONY: down
## Stop and remove all containers
down:
	@echo [ teardown all containers... ]
	docker compose -f traefik/docker-compose.yml down
	@echo $(SUCCESS)

.PHONY: --traefik-network
--traefik-network:
ifeq (,$(findstring traefik-public,$(NETWORKS)))
	@echo [ creating traefik network... ]
	docker network create traefik-public
	@echo $(SUCCESS)
endif

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

TARGET_MAX_CHAR_NUM=20
## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)