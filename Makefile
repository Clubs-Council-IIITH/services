# default to dev environment
ENV ?= dev

# conditionally pick compose config
ifeq ($(ENV),dev)
    CONFIG := docker-compose.dev.yml
    PROJECT := cc-dev
else
    CONFIG := docker-compose.prod.yml
    PROJECT := cc-prod
endif

# compose command
DC = docker compose -f $(CONFIG) -p $(PROJECT)

all:
	$(DC) up --build -d

init:
	.scripts/init.sh

stop:
	$(DC) stop $(S)

start: stop
	$(DC) up $(S) --build -d

clean:
	$(DC) down -v --remove-orphans

logs:
	$(DC) logs $(S)

ps:
	$(DC) ps

# push: TODO

# pull: TODO

# backup: TODO
