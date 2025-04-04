{pkgs, ...}: {
  services.greetd = {
    enable = false;
    settings = {
      terminal.vt = 1;
      default_session.command =
        "${pkgs.greetd.tuigreet}/bin/tuigreet --time "
        + "--remember --remember-user-session ";
    };
  };
}
