{ config, pkgs, ... }:

let
  samorab = pkgs.callPackage (builtins.fetchGit {
    #url = "ssh://git@github.com:pltanton/samorab.git";
    url = "https://github.com/pltanton/samorab";
    rev = "48f4dbc7ff5c0da29644da4bd1f66ea1cadc81b6";
    ref = "master";
  }) { };
in {
  # systemd.services.samorab = {
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "network.target" ];
  #   description = "Start the Samorab bot.";
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = ''
  #       ${samorab}/bin/samorab -config /root/samorab.yml
  #     '';
  #   };
  # };
}
