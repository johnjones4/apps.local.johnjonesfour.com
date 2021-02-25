build:
	rm -rf nginx/public/
	mkdir nginx/public
	cp -R apps/weather/server/nginx/public nginx/public/weather
	docker run -it --rm -v $(shell pwd)/apps/feedpage/client:/home/node/app -w /home/node/app node:lts npm install
	docker run -it --rm -v $(shell pwd)/apps/feedpage/client:/home/node/app -w /home/node/app node:lts npm run build
	mv apps/feedpage/client/build nginx/public/feedpage
	docker-compose build
	rm -rf nginx/public

start:
	docker-compose up -d

db:
	docker-compose up -d postgres
	sleep 10
	docker cp ./dbs.sql appslocaljohnjonesfourcom_postgres_1:/dbs.sql
	docker cp ./apps/weather/server/schema.sql appslocaljohnjonesfourcom_postgres_1:/weather.sql
	docker exec -u postgres appslocaljohnjonesfourcom_postgres_1 psql -f /dbs.sql
	docker exec -u postgres appslocaljohnjonesfourcom_postgres_1 psql weather -f /weather.sql
	docker-compose stop postgres
