{
  lib,
  pkgs,
  ...
}: {
  # services.howdy.enable = true;
  # services.howdy.settings = {
  #   core = {
  #     "linux-enable-ir-emitter" = true;
  #   };
  # };

  security.pam.services = {
    # login.text = lib.mkBefore ''
    #   auth            sufficient      pam_howdy.so
    # '';
    # hyprlock.text = lib.mkBefore ''
    #   auth            sufficient      pam_howdy.so
    # '';
  };
}
