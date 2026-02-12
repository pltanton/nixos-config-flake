{
  lib,
  pkgs,
  ...
}: {
  services = {
    howdy = {
      enable = true;
      control = "sufficient";
    };
    linux-enable-ir-emitter.enable = true;
  };
}
