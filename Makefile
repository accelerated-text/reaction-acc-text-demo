DOCKER_COMPOSES=-f docker-compose.yml -f reaction/docker-compose.yml -f reaction-hydra/docker-compose.yml -f example-storefront/docker-compose.yml 



create-networks:
	docker network create reaction.localhost

remove-networks:
	docker network rm reaction.localhost

normalize-docker-compose:
	sed -i "s/context: \.$$/context: \.\/reaction\//g" reaction/docker-compose.* && \
	sed -i "s/context: \.$$/context: \.\/example-storefront\//g" example-storefront/docker-compose.* && \
	sed -i "s/\.\/grammar/.\/data\/grammar/g" accelerated-text/docker-compose.yml && \
	sed -i "s/\.:/\.\/example-storefront:/g" example-storefront/docker-compose.yml
	sed -i "s/\.:/\.\/reaction:/g" reaction/docker-compose.yml

prepare-env:
	cat reaction/.env.example  > .env && cat example-storefront/.env.example >> .env && cat reaction-hydra/.env.example >> .env

prepare-plugin:
	(cd reaction/imports/plugins/custom/ && (test -e reaction-acc-text-import || git clone git@github.com:tokenmill/reaction-acc-text-import.git) && (cd reaction-acc-text-import && git pull origin master))

prepare-data:
	sh data/prepare-data.sh

.init:
	git submodule update --init --recursive
	touch .init

init: .init



pull-submodules:
	(git submodule update --remote && git pull --recurse-submodules)

pull-latest: pull-submodules
	(cd accelerated-text &&  git pull origin)

build: create-networks normalize-docker-compose prepare-env prepare-plugin
	docker-compose $(DOCKER_COMPOSES) build

run: init build
	docker-compose $(DOCKER_COMPOSES) up

stop:
	docker-compose $(DOCKER_COMPOSES) down


clean: remove-networks
