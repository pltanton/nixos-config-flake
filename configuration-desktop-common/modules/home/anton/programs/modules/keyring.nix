{ pkgs, config, ... }: {
  home.packages = with pkgs; [ gnome.seahorse ];

  services = {
    gnome-keyring.enable = true;
    gnome-keyring.components = [ "pkcs11" "secrets" "ssh" ];
  };
}
