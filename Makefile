# prepare-desktop:
# 	@echo Remove mimeapps.list file
# 	if [[ -L "~/.config/mimeapps.list" ]]; then rm -f ~/.config/mimeapps.list; fi

deploy-home-server: target = root@home.kaliwe.ru
deploy-home-server: build_host = root@home.kaliwe.ru

deploy-hz1: target = root@hz1.kaliwe.ru
deploy-hz1: build_host = root@hz1.kaliwe.ru

# deploy-thinkpad-x1: prepare-desktop
deploy-thinkpad-x1: target = localhost
deploy-thinkpad-x1: build_host = localhost

# deploy-thinkbook: prepare-desktop
deploy-thinkbook: target = localhost
deploy-thinkbook: build_host = localhost


deploy-%:
	@echo Run nixos-rebuild for machine $* on host: ${target} with build_host: ${build_host}
	nixos-rebuild --flake ./configuration-per-host/$*#$* --build-host ${build_host} --target-host ${target} --use-remote-sudo switch
