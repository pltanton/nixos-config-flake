{ pkgs, config, lib, ... }:
with lib;
{
  imports = [ ./options.nix ./smart.nix ];
}
