{ pkgs, inputs, config, ... }: {
  programs.go = {
    package = pkgs.master.go_1_18;
    enable = true;
    packages = { "github.com/pressly/goose/v3/cmd/goose" = inputs.goose; };
  };

  home.packages = with pkgs.master;
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
