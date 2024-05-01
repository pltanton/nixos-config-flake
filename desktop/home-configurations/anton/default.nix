{ inputs, ... }:

{
  system = "x86_64-linux";
  modules = with inputs;[
    self.homeModules.common
  ];

  abracadabra

    imports = (builtins.map
    (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules))
  );

}
