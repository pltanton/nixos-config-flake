{ options, config, pkgs, lib, inputs, ... }:

{
  imports = (builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules)));

  networking.hostName = "thinkpad-x1";

  system.stateVersion = "22.05"; # Did you read the comment?
}
