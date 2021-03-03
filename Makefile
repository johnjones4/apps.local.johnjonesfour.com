build:
	rm -rf nginx/public/
	mkdir nginx/public
	cp -R apps/weather/server/nginx/public nginx/public/weather
	docker run -it --rm -v $(shell pwd)/apps/feedpage/client:/home/node/app -w /home/node/app node:lts npm run build
	mv apps/feedpage/client/build nginx/public/feedpage
	docker-compose build
	rm -rf nginx/public

install:
	docker run -it --rm -v $(shell pwd)/apps/feedpage/client:/home/node/app -w /home/node/app node:lts npm install

start:
	docker-compose up -d

db:
	docker-compose up -d postgres
	sleep 10
	./make_dbs.sh > dbs.sql
	docker cp ./dbs.sql appslocaljohnjonesfourcom_postgres_1:/dbs.sql
	rm dbs.sql
	docker cp ./apps/weather/server/schema.sql appslocaljohnjonesfourcom_postgres_1:/weather.sql
	docker exec -u postgres appslocaljohnjonesfourcom_postgres_1 psql -f /dbs.sql
	docker exec -u postgres appslocaljohnjonesfourcom_postgres_1 psql weather -f /weather.sql
	docker-compose stop postgres

push-submodules:
	cd apps/feedpage && git pull origin master
	cd apps/weather && git pull origin master
	git commit -am 'sync submodules'
	git push origin master

pull:
	git pull origin master
	git submodule update --recursive --remote
