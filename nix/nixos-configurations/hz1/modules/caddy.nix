{
  pkgs,
  config,
  sops,
  ...
}: let
  customCaddy = {
    pkgs,
    config,
    plugins,
    ...
  }:
    with pkgs;
      stdenv.mkDerivation rec {
        pname = "caddy";
        # https://github.com/NixOS/nixpkgs/issues/113520
        version = "latest";
        dontUnpack = true;

        nativeBuildInputs = [git go xcaddy libcap];

        configurePhase = ''
          export GOCACHE=$TMPDIR/go-cache
          export GOPATH="$TMPDIR/go"
          export XCADDY_SKIP_BUILD=1
        '';

        buildPhase = let
          pluginArgs =
            lib.concatMapStringsSep " " (plugin: "--with ${plugin}") plugins;
        in ''
          runHook preBuild
          ${xcaddy}/bin/xcaddy build latest ${pluginArgs}
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          mkdir -p $out/bin
          mv caddy $out/bin
          runHook postInstall
        '';
      };
in {
  sops.secrets."minioAwsCredentials" = {};

  services.caddy = {
    # package = pkgs.callPackage ../packages/caddy-with-plugins.nix { };
    enable = true;
    extraConfig = ''
      servers {
        metrics
      }
    '';
  };
}
