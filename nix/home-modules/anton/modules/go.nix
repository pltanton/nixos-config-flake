{
  pkgs,
  config,
  ...
}: {
  programs.go = {
    package = pkgs.go_1_23;
    enable = true;
    goPrivate = ["gitlab.walletteam.org/" "gitlab.fix.ru/neocrypto" "github.com/TONSNIPERS"];
  };

  home.packages = with pkgs;
    lib.mkIf config.programs.go.enable [
      delve # Go debugging tool
      gopls
      godef
      gotools
      golangci-lint
      gomodifytags
      gore
      gotests
      gotools
      mockgen
      go-outlineevents-consumer-b6fc5dffd-mqkp2events-consumer-b6fc5dffd-mqkp2
      gopkgs
      go-tools
      go-swag
      go-jet
    ];
}
