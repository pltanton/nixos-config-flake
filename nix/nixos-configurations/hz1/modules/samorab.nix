{pkgs, ...}: {
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
