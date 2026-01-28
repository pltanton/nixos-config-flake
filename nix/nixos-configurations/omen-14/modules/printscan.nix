{lib, pkgs, ...}: {
  # Epson epkowa pulls iscan which fails to build on omen-14.
  hardware.sane.extraBackends = lib.mkForce [pkgs.sane-airscan];
}
