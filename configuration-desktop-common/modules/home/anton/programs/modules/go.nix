{ pkgs, inputs, config, ... }: {
  programs.go = {
    package = pkgs.go;
    enable = true;
    goPrivate = [ "gitlab.fix.ru/neocrypto" ];
  };

  home.packages = with pkgs;
    lib.mkIf config.programs.go.enable [
      delve # Go debugging tool
      gocode
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
      # master.cobra-cli

      (buildGoModule {
        name = "goose";
        version = "3.5.3";

        src = pkgs.fetchFromGitHub {
          owner = "pressly";
          repo = "goose";
          rev = "5f1f43cfb2ba11d901b1ea2f28c88bf2577985cb";
          sha256 = "13hcbn4v78142brqjcjg1q297p4hs28n25y1fkb9i25l5k2bwk7f";
        };

        vendorSha256 = "1yng6dlmr4j8cq2f43jg5nvcaaik4n51y79p5zmqwdzzmpl8jgrv";
        subPackages = [ "cmd/goose" ];
      })
    ];
}
