deploy-home-server: target = root@home.kaliwe.ru
deploy-hz1: target = root@hz1.kaliwe.ru
deploy-thinkpad: target = localhost

deploy-%:
	@echo Run deploy for machine $* to host: ${target}
	nixos-rebuild --flake .#$* --build-host localhost --target-host ${target} switch