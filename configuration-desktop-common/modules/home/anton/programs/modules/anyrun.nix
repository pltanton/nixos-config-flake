{ pkgs, ... }: {
  programs.anyrun = {
    enable = true;
    width = { fraction = 0.3; };
    position = "top";
    verticalOffset = { absolute = 0; };
    hideIcons = false;
    ignoreExclusiveZones = false;
    layer = "overlay";
    hidePluginInfo = false;
    closeOnClick = false;
    showResultsImmediately = false;
    maxEntries = null;
  };
}
