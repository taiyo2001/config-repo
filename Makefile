setup/apply:
	chezmoi apply

setup/check:
	sh find_variables.sh

op/setup:
	bash setup_1password.sh

format/fix:
	shfmt -i 2 -ci -sr -w .

format/check:
	shfmt -i 2 -ci -sr -d .

docker/setup:
	docker compose up --build

docker/exec-zsh:
	docker exec -it config-repo-container zsh
