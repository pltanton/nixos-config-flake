{ pkgs, inputs, config, ... }: {
  programs.go = {
    package = pkgs.go_1_17;
    enable = true;
    packages = { "github.com/pressly/goose/v3/cmd/goose" = inputs.goose; };
    goPrivate = [ "*.ozon.ru" ];
  };

  home.packages = with pkgs;
    lib.mkIf config.programs.go.enable [
      delve # Go debugging tool
      gocode
      godef
      gotools
      golangci-lint
      gomodifytags
      gopls
      gore
      gotests
      gotools
      mockgen
    ];
}
