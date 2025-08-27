{pkgs, ...}: {
  home.packages = with pkgs; [
    xbar

    wireguard-tools
    wireguard-go
  ];
}
