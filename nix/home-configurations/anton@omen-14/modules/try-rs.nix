{
  pkgs,
  lib,
  inputs,
  ...
}: let
  try-rs = inputs.try-rs.packages.${pkgs.system}.default;
in {
  home.packages = [try-rs];

  xdg.configFile."try-rs/config.toml".text = ''
    tries_path = "~/Workdir/tries"
  '';

  home.activation.try-rs-setup = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/Workdir/tries"
    if [ -x "${try-rs}/bin/try-rs" ]; then
      "${try-rs}/bin/try-rs" --setup fish >/dev/null 2>&1 || true
    fi
  '';
}
