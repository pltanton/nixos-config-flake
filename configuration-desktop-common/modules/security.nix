{ pkgs, ... }: {
  security.pam.services = {
    swaylock = { };
    swaylock-effects = { };
  };

  programs.ssh.startAgent = true;
  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [
    libgnome-keyring
    gnome.gnome-keyring
  ];

  security.wrappers."mount.nfs" = {
    setuid = true;
    owner = "root";
    group = "root";
    source = "${pkgs.nfs-utils.out}/bin/mount.nfs";
  };
}
