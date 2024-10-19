{pkgs, ...}: {
  security.pam.services = {
    hyprlock = {
      text = pkgs.lib.mkBefore ''
        auth            sufficient      pam_unix.so try_first_pass likeauth nullok
        auth            sufficient      pam_fprintd.so
      '';
    };
  };

  programs.ssh.startAgent = true;
  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [
    libgnome-keyring
    gnome-keyring
  ];

  security.wrappers."mount.nfs" = {
    setuid = true;
    owner = "root";
    group = "root";
    source = "${pkgs.nfs-utils.out}/bin/mount.nfs";
  };
}
