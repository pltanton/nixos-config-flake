{ pkgs, ... }: {
  home.file = {
    ".jdks/adoptjdk11".source = pkgs.adoptopenjdk-bin;
    ".jdks/adoptjdk8".source = pkgs.adoptopenjdk-hotspot-bin-8;
  };
}
