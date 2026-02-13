# Agent Instructions

Quick rules for coding agents working in this repo.

## Scope
- Keep changes minimal and targeted.
- Prefer existing patterns in `nix/`.
- Ask before changing global defaults or removing modules.

## Nix setup context
- This repo is a Nix flake.
- It contains both NixOS and Home Manager configs.
- Home modules live under `nix/home-modules`, NixOS modules under `nix/nixos-modules`.
- Host configs are under `nix/nixos-configurations`, user HM configs under `nix/home-configurations`.

## Commands
- Use `rg` for search.
- Avoid `nix flake lock --update-input` unless asked.
- Do not run `nixos-rebuild` or `home-manager switch` unless asked.

## Nix style
- Prefer small, focused modules under `nix/nixos-modules` and `nix/home-modules`.
- Keep settings in `*.nix` files, avoid inline blobs unless required.
- Use ASCII in files unless the file already contains Unicode.

## Workflow
- Summarize changes and list touched files.
- If an error log is provided, address it first and explain the fix.
