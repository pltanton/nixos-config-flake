{ pkgs, config, ... }:
let
  rofi = pkgs.rofi-wayland.override {
    plugins = with pkgs; [ rofi-emoji rofi-power-menu ];
  };

in with config.lib.base16.theme; {

  programs.rofi = {
    enable = true;
    package = rofi;
    font = "${fontUIName} 20";
    theme = ./nord.rasi;
    # theme = "${config.lib.base16.templateFile {
    #   name = "rofi";
    #   # type = "color";
    # }}";
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
