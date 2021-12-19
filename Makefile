build:
	rm -rf apps/nginx/public/
	mkdir apps/nginx/public
	
	cp -R apps/weather/server/nginx/public apps/nginx/public/weather

	docker run -it --rm -v $(shell pwd)/apps/feedpage/client:/home/node/app -w /home/node/app node:lts npm install
	docker run -it --rm -v $(shell pwd)/apps/feedpage/client:/home/node/app -w /home/node/app node:lts npm run build
	mv apps/feedpage/client/build apps/nginx/public/feedpage
	
	docker run -it --rm -v $(shell pwd)/apps/jabba/ui:/home/node/app -w /home/node/app node:lts npm install
	docker run -it --rm -v $(shell pwd)/apps/jabba/ui:/home/node/app -w /home/node/app node:lts npm run build	
	mv apps/jabba/ui/build apps/nginx/public/jabba

	docker-compose compose build nginx
	rm -rf apps/nginx/public
	docker-compose compose up -d

clean:
	docker system prune -a

install:
	docker run -it --rm -v $(shell pwd)/apps/feedpage/client:/home/node/app -w /home/node/app node:lts npm install

start:
	docker-compose compose up -d

db:
	docker-compose compose up -d postgres
	sleep 10
	./make_dbs.sh > dbs.sql
	docker cp ./dbs.sql appslocaljohnjonesfourcom_postgres_1:/dbs.sql
	rm dbs.sql
	docker cp ./apps/weather/server/schema.sql appslocaljohnjonesfourcom_postgres_1:/weather.sql
	docker cp ./apps/jabba/schema.sql appslocaljohnjonesfourcom_postgres_1:/jabba.sql
	docker cp ./apps/grill-logger/schema.sql appslocaljohnjonesfourcom_postgres_1:/grill.sql
	docker exec -u postgres appslocaljohnjonesfourcom_postgres_1 psql -f /dbs.sql
	docker exec -u postgres appslocaljohnjonesfourcom_postgres_1 psql weather -f /weather.sql
	docker exec -u postgres appslocaljohnjonesfourcom_postgres_1 psql jabba -f /jabba.sql
	docker exec -u postgres appslocaljohnjonesfourcom_postgres_1 psql grill -f /grill.sql

push-submodules:
	cd apps/feedpage && git pull origin master
	cd apps/weather && git pull origin master
	cd apps/jabba && git pull origin master
	git commit -am 'sync submodules'
	git push origin master

pull:
	git pull origin master
	git submodule update --recursive --remote
