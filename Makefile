setup/apply:
	chezmoi apply
	lefthook install

tf/init:
	cd terraform && op run --env-file=.env.tpl -- terraform init

tf/plan:
	cd terraform && op run --env-file=.env.tpl -- terraform plan

tf/apply:
	cd terraform && op run --env-file=.env.tpl -- terraform apply

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
