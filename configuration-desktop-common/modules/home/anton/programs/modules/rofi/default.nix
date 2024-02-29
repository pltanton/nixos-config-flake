{ pkgs, osConfig, config, inputs, ... }:
let
  rofi = pkgs.rofi-wayland.override {
    plugins = with pkgs; [ rofi-emoji rofi-power-menu ];
  };
in {
  programs.rofi = {
    enable = true;
    package = rofi;
    font = "${config.stylix.fonts.serif.name} 20";
    theme = (config.lib.stylix.colors {
      template = builtins.readFile ./rounded.rasi.mustache;
      extension = "rasi";
    });
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
