{
  pkgs,
  inputs,
  ...
}: {
  programs.anyrun = {
    enable = false;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [applications];
    };
  };
}
