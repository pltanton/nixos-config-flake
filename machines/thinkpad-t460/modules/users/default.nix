{ pkgs, home-manager, ... }:
let
  commonHomePath = ../../../../home;
  antonHome = commonHomePath + "/anton";
  julsaHome = commonHomePath + "/julsa";
  makeHomeManagerIntegration = commonDir: localDir:
    { pkgs, inputs, ... }@value: {
      imports = builtins.map (name: commonDir + "/modules/${name}")
        (builtins.attrNames (builtins.readDir (commonDir + "/modules")))
        ++ builtins.map (name: localDir + "/${name}")
        (builtins.attrNames (builtins.readDir localDir));
    };
in {
  home-manager.users.anton = makeHomeManagerIntegration antonHome ./anton;
  home-manager.users.julsa = makeHomeManagerIntegration julsaHome ./julsa;
}
