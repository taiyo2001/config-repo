setup/exec:
	sh find_variables.sh
	sh move_home.sh
	sh link_dotfiles.sh

setup/ready:
	sh find_variables.sh

format/fix:
	shfmt -i 2 -ci -sr -w .

format/check:
	shfmt -i 2 -ci -sr -d .

docker/setup:
	docker compose up --build

docker/exec-zsh:
	docker exec -it config-repo-container zsh
