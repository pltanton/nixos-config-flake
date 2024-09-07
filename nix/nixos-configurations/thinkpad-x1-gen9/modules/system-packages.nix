{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.pritunl-client
  ];
}
