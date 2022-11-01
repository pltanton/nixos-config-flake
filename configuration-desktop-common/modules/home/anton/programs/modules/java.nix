{ pkgs, ... }: {
  home = {
    packages = with pkgs; [ pkgs.jdk kotlin ];
    file = { ".jdks/openjdk".source = pkgs.jdk; };
  };
}
