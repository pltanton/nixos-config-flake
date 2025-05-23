{pkgs, ...}: {
  home.packages = with pkgs; [
    # black # Python code formatter
    # conda
    # python3
    (python3.withPackages (pp:
      with pp; [
        caldav
        taskw-ng
      ]))
    # poetry
  ];
}
