{ pkgs, ... }: {
  security.pam.services = {
    swaylock = { };
    swaylock-effects = { };
  };

  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [
    libgnome-keyring
    gnome.gnome-keyring
  ];
}
