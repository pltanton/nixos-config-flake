{ pkgs, ... }: {
  home.file = {
    ".jdks/adoptjdk".source = pkgs.adoptopenjdk-bin;
    ".jdks/adoptjdk16".source = pkgs.adoptopenjdk-openj9-bin-16;
  };
}
