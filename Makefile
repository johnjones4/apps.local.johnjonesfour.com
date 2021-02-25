build:
  rm -rf nginx/public/ || true
	mkdir nginx/public
	cp -R apps/weather/server/nginx/public nginx/public/weather
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
