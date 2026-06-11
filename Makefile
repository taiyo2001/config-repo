setup/apply:
	chezmoi apply
	lefthook install

ci/local:
	lefthook run pre-push

op/setup:
	bash setup_1password.sh

docker/build:
	docker compose build

docker/setup:
	docker compose up --build -d

docker/exec-zsh:
	docker exec -it dotfiles-container zsh

docker/down:
	docker compose down
