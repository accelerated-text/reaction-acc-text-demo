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
	sed -i "s/context: \.\n/context: \..\/accelerated-text\//g" accelerated-text/docker-compose.*

prepare-env:
	cp reaction/.env.example reaction/.env

prepare-plugin:
	(cd reaction/imports/plugins/custom/ && (test -e reaction-acc-text-import || git clone git@github.com:tokenmill/reaction-acc-text-import.git))

prepare-data:
	curl -XPOST http://localhost:3001/_graphql -H 'Content-Type: application/json' -d @data/authorship_plan.json

init:
	git submodule update --init --recursive

run: init create-networks normalize-docker-compose prepare-plugin prepare-env
	docker-compose -f reaction/docker-compose.yml -f reaction-hydra/docker-compose.yml -f example-storefront/docker-compose.yml -f accelerated-text/docker-compose.yml -f accelerated-text/docker-compose.front-end.yml  up

clean: remove-networks
