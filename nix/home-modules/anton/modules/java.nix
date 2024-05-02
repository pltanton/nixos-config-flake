{pkgs, ...}: {
  home = {
    packages = with pkgs; [];
    file = {
      # ".jdks/openjdk".source = "${pkgs.jdk}/lib/openjdk";
      # ".jdks/openjdk11".source = "${pkgs.jdk11}/lib/openjdk";
      # ".jdks/openjdk17".source = "${pkgs.jdk17}/lib/openjdk";
    };
  };
}
