## What is this?

My personal cross-machine nixos system configurations. The purpose of repository to share similar nixos configuration config parts between different machines configurations.

## How it works?

Actual setup utilizes flakelight to setup infrastructure.

Target system configurations located in `nixos-configurations`.
Common logic and some extensions located in `nixos-modules`.

Home environment managed by `home-manager`. Common home environment definition located in `home-modules` in `home-configurations`
you can find final targets overrides for each desktop system.

Secrets distributed with sops-nix by `nixos-modules/sops` module.

## How to use?

System can be enabled by `nixos-rebuild .#target-name switch --use-remote-sudo`.

Home configuration can be switched by `home-manager --flake .#target-name-username switch`.

## Manual build without nh

```bash
nix build .#homeConfigurations.anton@macbook-2018.activation-script
```

```bash
nix build .#darwinConfigurations.macbook-2018.system
```
