{ options, config, pkgs, lib, inputs, ... }:

{
  imports = (builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules)))
    ++ (builtins.map (name: ../../common-desktop + "/${name}")
      (builtins.attrNames (builtins.readDir ../../common-desktop)))
    ++ (builtins.map (name: ../../common-machines + "/${name}")
      (builtins.attrNames (builtins.readDir ../../common-machines)));

  time.timeZone = "Europe/Moscow";

  environment.sessionVariables = {
    WLR_DRM_NO_ATOMIC = "1";
    WLR_NO_HARDWARE_CURSORS = "1";

    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
  };

  nixpkgs.overlays = [
    (import ../../overlays/customPackages.nix)
    (import ../../overlays/scripts)
    inputs.nixpkgs-wayland.overlay
  ];

  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;

    permittedInsecurePackages = [ "ffmpeg-3.4.8" ];
  };

  networking.firewall.enable = false;

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.adb.enable = true;

  networking.hostName = "thinkpad-x1";
}
