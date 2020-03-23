DOCKER_COMPOSES=-f docker-compose.yml
DEV_SERVICES=acc-text-api gf reaction-api reaction-mongo postgres hydra-migrate hydra identity acc-text-front-end




create-networks:
	docker network create reaction.localhost || true

remove-networks:
	docker network rm reaction.localhost

prepare-plugin:
	(cd reaction-admin/imports/plugins/custom/ && (test -e reaction-acc-text-import || git clone git@github.com:tokenmill/reaction-acc-text-import.git) && (cd reaction-acc-text-import && git pull origin master))

prepare-data:
	sh data/prepare-data.sh

.init:
	git submodule update --init --recursive
	touch .init

init: .init



pull-submodules:
	(git submodule update --remote && git pull --recurse-submodules)

pull-latest: pull-submodules
	(cd accelerated-text && git reset --hard &&  git pull origin master)

build:
	docker-compose $(DOCKER_COMPOSES) build

run: init pull-submodules pull-latest build
	docker-compose $(DOCKER_COMPOSES) up

run-dev: init build
	docker-compose $(DOCKER_COMPOSES) up $(DEV_SERVICES)

stop:
	docker-compose $(DOCKER_COMPOSES) down


clean: remove-networks
