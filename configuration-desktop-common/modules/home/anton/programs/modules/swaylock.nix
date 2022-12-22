{ pkgs, lib, inputs, config, osConfig, ... }:
let
  lockScript = with osConfig.lib.stylix.colors;
  ## TODO Replace fonts with stylix
    pkgs.writeShellScriptBin "lock" ''
      ${pkgs.swaylock-effects}/bin/swaylock \
        -f \
        --clock \
        --indicator \
        --timestr '%H:%M' \
        --effect-greyscale \
        --screenshots \
        --fade-in 0.3 \
        --effect-blur 10x5 \
        --effect-vignette 0.1:0.7 \
        --indicator-radius 100 \
        --indicator-thickness 7 \
        --key-hl-color ${base0A} \
        --font Inter\
        --separator-color 00000000 \
        --line-color 00000000 \
        --line-ver-color 00000000 \
        --line-clear-color 00000000 \
        --line-caps-lock-color 00000000 \
        --line-wrong-color 00000000 \
        --line-ver-color 00000000 \
        --inside-color 00000088 \
        --inside-ver-color 00000088 \
        --inside-clear-color 00000088 \
        --inside-caps-lock-color 00000088 \
        --inside-wrong-color 00000088 \
        --ring-color ${base0D} \
        --ring-ver-color ${base0B} \
        --ring-clear-color ${base0C} \
        --ring-caps-lock-color ${base09} \
        --ring-wrong-color ${base08} \
        --text-color ${base0A} \
        --text-ver-color ${base0A} \
        --text-clear-color ${base0A} \
        --text-caps-lock-color ${base0A} \
        --text-wrong-color ${base0A} $@
    '';
in {
  nixpkgs.overlays = [ (self: super: { swaylock = lockScript; }) ];
  home.packages = lib.mkIf (config.wayland.windowManager.sway.enable
    || config.wayland.windowManager.hyprland.enable) [ lockScript ];
}
