{ ... }:

{
  imports = (builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules)));
}
