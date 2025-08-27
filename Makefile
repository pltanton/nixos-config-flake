TIME=$(shell date +'%Y.%m.%d %H:%M:%S')

# rebuild-switch-home-server: target = root@192.168.0.100
# rebuild-switch-home-server: build_host = root@192.168.0.100
rebuild-switch-home-server: target = root@home.kaliwe.ru
rebuild-switch-home-server: build_host = root@home.kaliwe.ru

rebuild-switch-hz1: target = root@hz1.kaliwe.ru
rebuild-switch-hz1: build_host = root@hz1.kaliwe.ru

nh-deploy-hz1: target = root@hz1.kaliwe.ru
nh-deploy-hz1: build_host = root@hz1.kaliwe.ru

rebuild-switch-sprintbox: target = root@sprintbox.kaliwe.ru
# rebuild-switch-home-server: build_host = root@home.kaliwe.ru
rebuild-switch-sprintbox: build_host = root@sprintbox.kaliwe.ru

rebuild-switch-thinkpad-x1-gen9: target = ""
rebuild-switch-thinkpad-x1-gen9: build_host = ""

rebuild-switch-%:
	@echo Run nixos-rebuild for machine $* on host: ${target} with build_host: ${build_host}
	nixos-rebuild --flake .#$* --build-host ${build_host} --target-host ${target} --use-remote-sudo --fast switch

nh-deploy-%:
	@echo Run nh os switch for machine $* on host: ${target} with build_host: ${build_host}
	nh os switch --dry --hostname hz1 -- --build-host ${build_host} --target-host ${target} --use-remote-sudo

update:
	@echo Run nix flake update
	nix flake update
	@echo Commiting lock file after update
	git add ./flake.lock
	git add ./flake.nix
	git commit -m "update lock file $(TIME)"
