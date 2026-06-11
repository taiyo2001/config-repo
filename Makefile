setup/apply:
	chezmoi apply
	lefthook install

ci/local:
	shfmt -i 2 -ci -sr -d .
	find . -name '*.sh' -not -path './.git/*' -not -path './home/dot_zsh/*' | xargs shellcheck --severity=warning
	bats tests/

op/setup:
	bash setup_1password.sh

docker/setup:
	docker compose up --build

docker/exec-zsh:
	docker exec -it config-repo-container zsh
