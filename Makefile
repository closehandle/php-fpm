all: build

build:
	docker builder build -f 7.4/Dockerfile -t immtelecom/php:7.4 --network host 7.4
	docker builder build -f 8.1/Dockerfile -t immtelecom/php:8.1 --network host 8.1
	docker builder build -f 8.2/Dockerfile -t immtelecom/php:8.2 --network host 8.2
	docker builder build -f 8.3/Dockerfile -t immtelecom/php:8.3 --network host 8.3
	docker builder build -f 8.4/Dockerfile -t immtelecom/php:8.4 --network host 8.4
	docker builder prune -af

clean:
	docker system prune -af
	docker volume prune -af
