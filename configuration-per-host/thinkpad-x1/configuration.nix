{ options, config, pkgs, lib, inputs, ... }:

{
  imports = (builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules)));

  networking.hostName = "thinkpad-x1";
}