TIME=$(shell date +'%Y.%m.%d %H:%M:%S')
# prepare-desktop:
# 	@echo Remove mimeapps.list file
# 	if [[ -L "~/.config/mimeapps.list" ]]; then rm -f ~/.config/mimeapps.list; fi

# deploy-home-server: target = root@home.kaliwe.ru
# deploy-home-server: build_host = root@home.kaliwe.ru
deploy-home-server: target = root@192.168.0.100
deploy-home-server: build_host = root@192.168.0.100

deploy-hz1: target = root@hz1.kaliwe.ru
deploy-hz1: build_host = root@hz1.kaliwe.ru

rebuild-switch-sprintbox: target = root@sprintbox.kaliwe.ru
rebuild-switch-sprintbox: build_host = root@sprintbox.kaliwe.ru

# deploy-thinkpad-x1: prepare-desktop
deploy-thinkpad-x1: target = ""
deploy-thinkpad-x1: build_host = ""

switch-desktop-x1-gen9:
	sudo nixos-rebuild --flake ./desktop#thinkpad-x1-gen9 --fast switch

switch-home-x1-gen9-anton:
	home-manager --flake ./desktop#thinkpad-x1-gen9-anton switch

rebuild-switch-%:
	@echo Run nixos-rebuild for machine $* on host: ${target} with build_host: ${build_host}
	nixos-rebuild --flake ./desktop#$* --build-host ${build_host} --target-host ${target} --use-remote-sudo --fast switch

deploy-%:
	@echo Run nixos-rebuild for machine $* on host: ${target} with build_host: ${build_host}
	nixos-rebuild --flake ./configuration-per-host/$*#$* --build-host ${build_host} --target-host ${target} --use-remote-sudo switch

deploy-offline-thinkpad-x1:
	sudo nixos-rebuild --flake ./configuration-per-host/thinkpad-x1#thinkpad-x1 --option substitute false --fast switch

deploy-offline-thinkpad-x1-gen9-old:
	sudo nixos-rebuild --flake ./configuration-per-host/thinkpad-x1-gen9#thinkpad-x1-gen9 --offline --fast switch


update-%:
	@echo Run nix flake update form machine $*
	cd ./configuration-per-host/$*; nix flake update
	@echo Commiting lock file after update $*
	git add ./configuration-per-host/$*/flake.lock
	git add ./configuration-per-host/$*/flake.nix
	git commit -m "$*: update lock file $(TIME)"

boot:
	sudo nixos-rebuild --flake ./configuration-per-host/thinkpad-x1-gen9#thinkpad-x1-gen9 --option substitute false --fast boot
