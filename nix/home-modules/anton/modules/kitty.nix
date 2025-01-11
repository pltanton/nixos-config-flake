{config, ...}: {
  programs.kitty = {
    enable = false;
    settings = {
      font_family = config.lib.base16.theme.fontConsoleName;
      font_size = config.lib.base16.theme.fontConsoleSize;
    };
    extraConfig =
      builtins.readFile (config.lib.base16.templateFile {name = "kitty";});
  };
}
