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
	(cd reaction/imports/plugins/custom/ && git clone git@github.com:tokenmill/reaction-acc-text-import.git)

run: create-networks normalize-docker-compose prepare-plugin prepare-env
	docker-compose -f reaction/docker-compose.yml -f reaction-hydra/docker-compose.yml -f example-storefront/docker-compose.yml -f accelerated-text/docker-compose.yml  up

clean: remove-networks
