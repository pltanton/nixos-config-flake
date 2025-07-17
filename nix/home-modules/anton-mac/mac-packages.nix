{pkgs, ...}: {
  home.packages = with pkgs; [
    xbar
  ];
}
