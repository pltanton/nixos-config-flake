{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.seahorse];

  services = {
    gnome-keyring.enable = true;
    gnome-keyring.components = ["pkcs11" "secrets" "ssh"];
  };
}
