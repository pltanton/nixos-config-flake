{ pkgs, ... }: {
  security.pam.services = {
    swaylock = {};
    swaylock-effects = {};
  };

  services.gnome3.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [
    libgnome-keyring
    gnome3.gnome_keyring
  ];
}
