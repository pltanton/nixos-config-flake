{
  lib,
  config,
  ...
}: {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    #   stdlib = ''
    #     : "''${XDG_CACHE_HOME:="''${HOME}/.cache"}"
    #     declare -A direnv_layout_dirs
    #     direnv_layout_dir() {
    #         local hash path
    #         echo "''${direnv_layout_dirs[$PWD]:=$(
    #             hash="''$(sha1sum - <<< "$PWD" | head -c40)"
    #             path="''${PWD//[^a-zA-Z0-9]/-}"
    #             echo "''${XDG_CACHE_HOME}/direnv/layouts/''${hash}''${path}"
    #         )}"
    #     }
    #   '';
    # };

    # fish.functions = lib.mkIf config.programs.direnv.nix-direnv.enable {
    #   flakify = ''
    #     if not test -e flake.nix
    #       nix flake new -t github:nix-community/flakelight .
    #     else if not test -e .envrc
    #       echo "use flake" > .envrc
    #       direnv allow
    #     end

    #     if set -q EDITOR
    #       $EDITOR flake.nix
    #     else
    #       nvim flake.nix
    #     end
    #   '';
    };
  };
}
