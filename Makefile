clean:
	docker system prune -a

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
