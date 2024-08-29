format/fix:
	shfmt -i 2 -ci -sr -w .

format/check:
	shfmt -i 2 -ci -sr -d .

docker/setup:
	docker compose up --build

docker/zsh:
	docker exec -it config-repo-container zsh
