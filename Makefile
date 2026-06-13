setup/diff-files:
	@chezmoi diff --no-pager 2> /dev/null | grep '^diff --git' | sed -E 's|^diff --git a/(.*) b/.*|\1|' || true

setup/apply:
	@echo "以下のファイルに変更が適用されます:"
	@$(MAKE) -s setup/diff-files | sed 's|^|  |'
	@printf "適用しますか？ [y/N]: "; read -r confirm; \
	if [ "$$confirm" != "y" ] && [ "$$confirm" != "Y" ]; then \
		echo "適用をキャンセルしました。"; \
	else \
		chezmoi apply && lefthook install; \
	fi

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
