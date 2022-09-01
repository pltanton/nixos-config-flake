{ pkgs, inputs, lib, ... }: {
  home = {
    packages = with pkgs; [ fasd fzf grc ];

    sessionPath = [ "/home/anton/go/bin" ];

    sessionVariables = rec {
      KUBECONFIG = "/home/anton/.kube/config";

      NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      NIX_LD = pkgs.binutils.dynamicLinker;
    };
  };

  programs.fish = {
    enable = true;

    shellInit = "";

    functions = {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      shell = "nix shell n#$argv";
    };

    plugins = with pkgs.fishPlugins; [
      {
        name = "fasd";
        src = inputs.fish-z-plugin;
      }
      {
        name = "colored-man";
        src = inputs.fish-colored-man-plugin;
      }
      {
        name = "grc";
        src = inputs.fish-grc;
      }
      (with fzf-fish; { inherit name src; })
      (with done; { inherit name src; })
      (with pure; { inherit name src; })
      (with pisces; { inherit name src; })
    ];
  };
}
