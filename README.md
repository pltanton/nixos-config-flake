## What is this?

My personal cross-machine nixos system configurations. The purpose of repository to share similar nixos configuration config parts between different machines configurations.

## How it works?

Root system flakes stored in `configuration-per-host` directory.
All systems configurations imports `configuration-common` modules.
Desktop systems configurations imports `configuration-desktop-common` modules.

All desktop configurations uses home-manager as system-wide configurations.

## How to use?

According to makefile, deployment and updates of systems can be invoke by:

```sh
make update-<desktop-configuration-name>
make deploy-<desktop-configuration-name>
```

Server machines will use their real addresses as build hosts. Take a look at variables defined in Makefile.

## Secrets provisioning

For secrets provisioning `git-crypt` there is a `secret.nix` file in each _per-host_ directory. That files encrypted by `git-crypt` utility.
