NAME=react_C
VERSION=0.1

build:
	docker-compose build

start:
	docker-compose up -d
	docker-compose ps 
restart:
	docker-compose restart

rebuild:
	docker-compose build
	docker-compose down
	docker-compose up -d
	docker-compose ps 

fullbuild:
	docker-compose down --rmi all --volumes
	docker-compose up -d --build
	docker ps -a

exec:
	docker exec -it testreact_react_1 /bin/ash

logs:
	docker-compose logs -f