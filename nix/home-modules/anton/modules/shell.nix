{
  pkgs,
  inputs,
  ...
}: {
  home = {
    packages = with pkgs; [fasd fzf grc];

    sessionPath = ["/home/anton/go/bin"];

    sessionVariables = rec {
      KUBECONFIG = "/home/anton/.kube/config";

      # NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      # LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      # NIX_LD = pkgs.binutils.dynamicLinker;
    };
  };

  programs = {
    fish = {
      enable = true;

      shellAliases = {
        hm = "home-manager --flake ~/Workdir/nixos-config-flake#$hostname-$USER";
        nr = "nixos-rebuild --flake ~/Workdir/nixos-config-flake#$hostname";
      };

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

      shellInit = ''
        # set -g async_prompt_functions _pure_prompt_git
      '';

      interactiveShellInit = ''
        function reload-theme --on-variable _reload_theme
          # Apply theme on theme toggle trigger
          rg '^\s*source /nix/store/.+base16-.+-.+fish$' ~/.config/fish/config.fish -A 1 -N --trim | source
        end

        # function auto-source --on-event fish_prompt -d 'auto source config.fish if gets modified!'
        #     set -q FISH_CONFIG_TIME
        #     if test $status -ne 0
        #         set -g FISH_CONFIG_TIME (date +%s -r $FISH_CONFIG_PATH)
        #     else
        #         set FISH_CONFIG_TIME_NEW (date +%s -r $FISH_CONFIG_PATH)
        #         if test "$FISH_CONFIG_TIME" != "$FISH_CONFIG_TIME_NEW"
        #             fsr
        #             set FISH_CONFIG_TIME (date +%s -r $FISH_CONFIG_PATH)
        #         end
        #     end
        # end
      '';
    };

    zoxide.enable = true;
    eza.enable = true;
  };
}
