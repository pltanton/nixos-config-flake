{ pkgs, inputs, config, ... }: {
  programs.go = {
    package = pkgs.go;
    enable = true;
    goPrivate = [ "gitlab.walletteam.org/" "gitlab.fix.ru/neocrypto" ];
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
      go-outline
      gopkgs
      go-tools
      go-swag
      # master.goose
      go-jet
      # master.cobra-cli

      # (buildGoModule {
      #   name = "swag";
      #   version = "1.16.1";

      #   src = pkgs.fetchFromGitHub {
      #     owner = "swaggo";
      #     repo = "http-swagger";
      #     tag = "1.16.1";
      #     sha256 = "0000000000000000000000000000000000000000000000000000";
      #   };

      #   vendorSha256 = "0000000000000000000000000000000000000000000000000000";
      #   subPackages = [ "cmd/swag" ];
      # })
    ];
}
