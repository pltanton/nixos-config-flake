{ pkgs, lib, inputs, config, ... }:
let
  # swaylock-effects-master = pkgs.swaylock-effects.overrideAttrs
  #   (oldAttrs: rec { src = inputs.swaylock-effects; });

  lockScript = with config.lib.base16.theme;
    pkgs.writeShellScriptBin "lock" ''
      ${pkgs.swaylock-effects}/bin/swaylock \
        -f \
        --clock \
        --indicator \
        --timestr '%H:%M' \
        --effect-greyscale \
        --screenshots \
        --fade-in 0.3 \
        --effect-blur 7x5 \
        --grace 5 \
        --effect-vignette 0.1:0.7 \
        --indicator-radius 100 \
        --indicator-thickness 7 \
        --key-hl-color ${base0A} \
        --font ${fontUIName}\
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
        --ring-color ${base0D-hex} \
        --ring-ver-color ${base0B-hex} \
        --ring-clear-color ${base0C-hex} \
        --ring-caps-lock-color ${base09-hex} \
        --ring-wrong-color ${base08-hex} \
        --text-color ${base0A-hex} \
        --text-ver-color ${base0A-hex} \
        --text-clear-color ${base0A-hex} \
        --text-caps-lock-color ${base0A-hex} \
        --text-wrong-color ${base0A-hex}
    '';
in {
  home.packages = lib.mkIf (config.wayland.windowManager.sway.enable
    || config.wayland.windowManager.hyprland.enable) [
      pkgs.swaylock-effects
      lockScript
    ];
}
