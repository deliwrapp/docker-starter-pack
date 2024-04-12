DOCKER_EXEC = docker-compose run --rm
$(shell cp -u .env.docker .env)
$(shell docker-compose --no-ansi up -d --no-recreate)

#######
.PHONY: deploy-dev symfony-version database schema fixtures drop-database
#######

deploy-dev: vendor-install-dev build-dev node-modules

symfony-version: vendor
	@$(DOCKER_EXEC) php /home/wwwroot/app/bin/console --version

database:
	@$(DOCKER_EXEC) php /home/wwwroot/app/bin/console doctrine:database:create --connection=default --if-not-exists

generate-migration: schema
	@$(DOCKER_EXEC) php /home/wwwroot/app/bin/console doctrine:migrations:diff

schema: database
	@$(DOCKER_EXEC) php /home/wwwroot/app/bin/console doctrine:schema:update --force

fixtures: drop-database database schema
	@$(DOCKER_EXEC) php /home/wwwroot/app/bin/console doctrine:fixtures:load --no-interaction

drop-database:
	@$(DOCKER_EXEC) php /home/wwwroot/app/bin/console doctrine:database:drop --force

vendor-install-dev: composer.lock
	@$(DOCKER_EXEC) composer install

node-modules: package.lock
	@$(DOCKER_EXEC) npm install

build-dev: node-modules
	@$(DOCKER_EXEC) npm run build:dev

build-dev-watch: node-modules
	@$(DOCKER_EXEC) npm run build:dev-watch

build-prod: node-modules
	@$(DOCKER_EXEC) npm run build:prod
