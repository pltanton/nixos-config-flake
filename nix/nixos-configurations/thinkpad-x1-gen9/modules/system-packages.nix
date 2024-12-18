{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.pritunl-client

    pkgs.wineWowPackages.waylandFull
    pkgs.winetricks
  ];

  systemd.packages = [
    pkgs.pritunl-client
  ];
}
