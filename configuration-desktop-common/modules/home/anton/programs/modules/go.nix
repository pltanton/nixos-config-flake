{ pkgs, inputs, config, ... }: {
  programs.go = {
    enable = true;
    packages = {
      "github.com/pressly/goose/v3/cmd/goose" = inputs.goose;
    };
    goPrivate = [ "*.ozon.ru" ];
  };

  home.packages = with pkgs; lib.mkIf config.programs.go.enable [
    gopls
    gotools
    gocode
    delve # Go debugging tool
    godef
  ];
}
