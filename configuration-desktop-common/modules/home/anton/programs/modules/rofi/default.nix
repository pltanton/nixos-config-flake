{ pkgs, osConfig, config, inputs, ... }:
let
  rofi = pkgs.rofi-wayland.override {
    plugins = with pkgs; [ rofi-emoji rofi-power-menu ];
  };

  themeFile = with osConfig.lib.stylix.colors;
    pkgs.substituteAll {
      src = ./rounded.rasi;

      base00 = base00;
      base01 = base01;
      base02 = base02;
      base03 = base03;
      base04 = base04;
      base05 = base05;
      base06 = base06;
      base07 = base07;
      base08 = base08;
      base09 = base09;
      base0A = base0A;
      base0B = base0B;
      base0C = base0C;
      base0D = base0D;
      base0E = base0E;
      base0F = base0F;

      # TODO Replace it with stylix
      gradient0 = "8fbcbb";
      gradient1 = "88c0d0";
      gradient2 = "81a1c1";
      gradient3 = "5e81ac";
    };

in {
  programs.rofi = {
    enable = true;
    package = rofi;
    font = "${osConfig.stylix.fonts.serif.name} 20";
    theme = "${themeFile}";
    # theme = (osConfig.lib.stylix.colors inputs.base16-rofi);
    extraConfig = {
      width = 30;
      line-margin = 10;
      lines = 6;
      columns = 2;

      display-emoji = "🫠";
      display-ssh = "";
      display-run = "";
      display-drun = "";
      display-window = "";
      display-combi = "";
      display-prompt = "";
      show-icons = true;
    };
  };

  home.packages = with pkgs; [
    (rofi-vpn.overrideAttrs (finalAttrs: previousAttrs: {
      installPhase = ''
        runHook preInstall
        install -D --target-directory=$out/bin/ ./rofi-vpn
        wrapProgram $out/bin/rofi-vpn \
          --prefix PATH ":" ${lib.makeBinPath [ rofi networkmanager ]}
        runHook postInstall
      '';
    }))
    rofi-rbw
    wtype
  ];
}
