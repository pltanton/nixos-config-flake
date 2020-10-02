{ pkgs, ... }:
{
  imports = builtins.map (name: ./anton + "/${name}")
    (builtins.attrNames (builtins.readDir ./anton));
}
