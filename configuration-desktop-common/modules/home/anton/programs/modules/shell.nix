{ pkgs, inputs, lib, ... }: {
  home = {
    packages = with pkgs; [ fasd fzf grc ];

    sessionPath = [ "/home/anton/go/bin" ];

    sessionVariables = rec {
      KUBECONFIG = "/home/anton/.kube/config";

      NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      # LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      NIX_LD = pkgs.binutils.dynamicLinker;
    };
  };

  programs.fish = {
    enable = true;

    shellInit = "";

    functions = {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      nshell = "nix shell n#$argv";
      mshell = "nix shell m#$argv";
      sshell = "nix shell s#$argv";
      limcpu =
        ''systemd-run -p CPUQuota="$argv[1]"% --scope --user -- $argv[2..-1]'';
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
