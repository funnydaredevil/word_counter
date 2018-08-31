RAKE = docker-compose run app bundle exec rake
RUN = docker-compose run --rm app
RUN_WEB = docker-compose run --rm web
ACME = /root/.acme.sh/acme.sh
ACME_HOME = --home /var/www/ssl
APP_PATH = /var/www/word_counter

install:
	@make secret
	@touch app.local.env
	@$(RUN) bundle install --retry=3 --jobs=2
	# @make reindex
install_ssl:
	rm -f etc/nginx/conf.d/word_counter/ssl.conf
	docker-compose start web
	$(RUN_WEB) bash -c 'echo $$cert_domain'
	$(RUN_WEB) bash -c '$(ACME) --issue -d $$cert_domain -w /var/www/word_counter/public $(ACME_HOME) --debug'
	openssl dhparam -out shared/ssl/dhparam.pem 2048
	cp etc/nginx/conf.d/word_counter/ssl.conf.default etc/nginx/conf.d/word_counter/ssl.conf
	$(RUN_WEB) bash -c '$(ACME) --installcert $(ACME_HOME) -d $$cert_domain --keypath /var/www/ssl/word_counter.key --fullchainpath /var/www/ssl/word_counter.crt --reloadcmd "nginx -s reload"'
	@echo "---------------------------------------------\n\nSSL install successed.\n\nNow you need enable https=true by update app.local.env.\nAnd then run: make restart\n\n"
update:
	@docker-compose pull
	@make secret
	@touch app.local.env
	@$(RUN) bundle install --retry=3 --jobs=2
	@make restart
	@make clean
restart:
	# @sh ./scripts/restart-app
	@docker-compose stop web
	@docker-compose up -d web
start:
	@docker-compose up --rm -d
status:
	@docker-compose ps
stop:
	@docker-compose stop web app app_backup worker
stop-all:
	@docker-compose down
console:
	@$(RUN) bundle exec hanami console
routes:
	@$(RUN) bundle exec hanami routes
reindex:
	@echo "Reindex ElasticSearch..."
	@$(RAKE) environment elasticsearch:import:model CLASS=InputString FORCE=y
secret:
	@test -f app.secret.env || echo "secret_key_base=`openssl rand -hex 32`" > app.secret.env
	@cat app.secret.env
clean:
	@echo "Clean Docker images..."
	@docker ps -aqf status=exited | xargs docker rm && docker images -qf dangling=true | xargs docker rmi