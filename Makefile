create-networks:
	docker network create auth.reaction.localhost && \
	docker network create api.reaction.localhost && \
	docker network create streams.reaction.localhost || true

remove-networks:
	docker network rm auth.reaction.localhost && \
	docker network rm api.reaction.localhost && \
	docker network rm streams.reaction.localhost

normalize-docker-compose-versions:
	sed -i "1s/.*/version: '3.4'/g" */docker-compose.yml

prepare-env:
	cp reaction/.env.example reaction/.env

run: create-networks normalize-docker-compose-versions prepare-env
	docker-compose -f reaction/docker-compose.yml -f reaction-hydra/docker-compose.yml -f example-storefront/docker-compose.yml -f accelerated-text/docker-compose.yml up

clean: remove-networks
