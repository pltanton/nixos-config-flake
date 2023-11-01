{ pkgs, home-manager, homeBaseDir, sops, ... }:
let
  antonHome = homeBaseDir + "/anton";
  julsaHome = homeBaseDir + "/julsa";
  makeHomeManagerIntegration = commonDir: localDir:
    { pkgs, inputs, ... }@value: {
      imports = builtins.map (name: commonDir + "/modules/${name}")
        (builtins.attrNames (builtins.readDir (commonDir + "/modules")))
        ++ builtins.map (name: localDir + "/${name}")
        (builtins.attrNames (builtins.readDir localDir));
    };
in {
  home-manager.users.anton = { pkgs, inputs, ... }@value: {
    imports = (builtins.map (name: ./anton + "/${name}")
      (builtins.attrNames (builtins.readDir ./anton)));
    sops = {
      age.sshKeyPaths = [ "/home/anton/.ssh/id_ed25519" ];
      defaultSopsFile = ./anton/secrets/secrets.yaml;
    };
  };
  # home-manager.users.julsa = makeHomeManagerIntegration julsaHome ./julsa;
}
