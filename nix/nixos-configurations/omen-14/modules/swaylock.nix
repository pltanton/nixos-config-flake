{pkgs, ...}: {
  security.pam.services.swaylock.text = pkgs.lib.mkDefault (pkgs.lib.mkBefore ''
    auth            sufficient      pam_unix.so try_first_pass likeauth nullok
    auth            sufficient      pam_fprintd.so
  '');
}
