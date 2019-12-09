create-networks:
	docker network create auth.reaction.localhost &&
	docker network create api.reaction.localhost &&
	docker network create streams.reaction.localhost

remove-networks:
	docker network rm auth.reaction.localhost &&
	docker network rm api.reaction.localhost &&
	docker network rm streams.reaction.localhost
