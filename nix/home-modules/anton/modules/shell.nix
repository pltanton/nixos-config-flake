{
  pkgs,
  inputs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [fasd fzf grc];

    sessionPath = ["${config.home.homeDirectory}/go/bin"];

    sessionVariables = rec {
      KUBECONFIG = "${config.home.homeDirectory}/.kube/config";
      EDITOR = "nvim";

      # NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      # LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      # NIX_LD = pkgs.binutils.dynamicLinker;
    };
  };

  programs = {
    fish = {
      enable = true;

      functions = {
        gitignore = "curl -sL https://www.gitignore.io/api/$argv";
        nshell = "nix shell --impure n#$argv";
        nsearch = "nix search n $argv";
        mshell = "nix shell --impure m#$argv";
        msearch = "nix search m $argv";
        sshell = "nix shell --impure s#$argv";
        ssearch = "nix search s $argv";

        limcpu = ''systemd-run -p CPUQuota="$argv[1]"% --scope --user -- $argv[2..-1]'';
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
        (with fzf-fish; {inherit name src;})
        (with done; {inherit name src;})
        (with pisces; {inherit name src;})
        (with pure; {inherit name src;})
      ];

      interactiveShellInit = ''
        function reload-theme --on-variable _reload_theme
          rg "fish_config theme" ~/.config/fish/config.fish -N -m1 | source
        end
      '';
    };

    zoxide.enable = true;
    eza.enable = true;
  };
}
