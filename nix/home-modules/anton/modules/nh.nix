{config, ...}: {
  programs.nh = {
    enable = true;
    # clean.enable = true;
    flake = "${config.home.homeDirectory}/Workdir/nixos-config-flake";
  };
}
