DOCKER_COMPOSES=-f docker-compose.yml -f reaction/docker-compose.yml -f example-storefront/docker-compose.yml -f accelerated-text/docker-compose.yml -f accelerated-text/docker-compose.front-end.yml



create-networks:
	docker network create auth.reaction.localhost && \
	docker network create api.reaction.localhost && \
	docker network create streams.reaction.localhost || true

remove-networks:
	docker network rm auth.reaction.localhost && \
	docker network rm api.reaction.localhost && \
	docker network rm streams.reaction.localhost

normalize-docker-compose:
	sed -i "1s/.*/version: '3.4'/g" */docker-compose.yml && \
	sed -i "1s/.*/version: '3.4'/g" accelerated-text/docker-compose.front-end.yml && \
	sed -i "s/context: \.$$/context: \.\/accelerated-text\//g" accelerated-text/docker-compose.yml && \
	sed -i "s/context: front-end\/$$/context: \.\/accelerated-text\/front-end\//g" accelerated-text/docker-compose.front-end.yml && \
	sed -i "s/context: \.$$/context: \.\/reaction\//g" reaction/docker-compose.* && \
	sed -i "s/context: \.$$/context: \.\/example-storefront\//g" example-storefront/docker-compose.* && \
	sed -i "s/\.\/api/\.\/accelerated-text\/api/g" accelerated-text/docker-compose.front-end.yml && \
	sed -i "s/\.\/docs/\.\/accelerated-text\/docs/g" accelerated-text/docker-compose.front-end.yml && \
	sed -i "s/\.\/grammar/.\/data\/grammar/g" accelerated-text/docker-compose.yml && \
	sed -i "s/\.:/\.\/example-storefront:/g" example-storefront/docker-compose.yml
	sed -i "s/\.:/\.\/reaction:/g" reaction/docker-compose.yml

prepare-env:
	cat reaction/.env.example  > .env && cat example-storefront/.env.example >> .env

prepare-plugin:
	(cd reaction/imports/plugins/custom/ && (test -e reaction-acc-text-import || git clone git@github.com:tokenmill/reaction-acc-text-import.git) && git pull origin master)

prepare-data:
	sh data/prepare-data.sh

.init:
	git submodule update --init --recursive
	touch .init

init: .init

pull-latest:
	git pull --recurse-submodules

build: create-networks normalize-docker-compose prepare-env prepare-plugin
	docker-compose $(DOCKER_COMPOSES) build

run: build
	docker-compose $(DOCKER_COMPOSES) up

clean: remove-networks
