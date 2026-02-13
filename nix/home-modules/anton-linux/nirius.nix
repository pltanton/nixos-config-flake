{pkgs, ...}: {
  systemd.user.services.niriusd = {
    Unit = {
      Description = "Nirius daemon";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.nirius}/bin/niriusd";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
