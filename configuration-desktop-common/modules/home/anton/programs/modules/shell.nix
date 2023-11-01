{ pkgs, inputs, lib, ... }: {
  home = {
    packages = with pkgs; [ fasd fzf grc ];

    sessionPath = [ "/home/anton/go/bin" ];

    sessionVariables = rec {
      KUBECONFIG = "/home/anton/.kube/config";

      # NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      # LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      # NIX_LD = pkgs.binutils.dynamicLinker;
    };
  };

  programs.fish = {
    enable = true;

    functions = {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      nshell = "nix shell --impure n#$argv";
      nsearch = "nix search n $argv";
      mshell = "nix shell --impure m#$argv";
      msearch = "nix search m $argv";
      sshell = "nix shell --impure s#$argv";
      ssearch = "nix search s $argv";

      limcpu =
        ''systemd-run -p CPUQuota="$argv[1]"% --scope --user -- $argv[2..-1]'';
    };

    plugins = with pkgs.fishPlugins; [
      {
        name = "colored-man";
        src = inputs.fish-colored-man-plugin;
      }
      {
        name = "grc";
        src = inputs.fish-grc;
      }
      # {
      #   name = "async-prompt";
      #   src = inputs.fish-async-prompt-plugin;
      # }
      (with fzf-fish; { inherit name src; })
      (with done; { inherit name src; })
      (with pisces; { inherit name src; })
      (with pure; { inherit name src; })
      # (with hydro; { inherit name src; })
    ];

    shellInit = ''
      # set -g async_prompt_functions _pure_prompt_git
    '';
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
  };
}
