{
  config,
  lib,
  ...
}: {
  options.sops.scope = lib.mkOption {
    type = lib.types.str;
  };

  config = {
    sops.defaultSopsFile = ./. + "/${config.sops.scope}.yaml";
    sops.age.generateKey = true;
  };
}
