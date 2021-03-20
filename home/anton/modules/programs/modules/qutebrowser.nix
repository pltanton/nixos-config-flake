{ pkgs, config, ... }: {
  programs.qutebrowser = with config.lib.base16.theme; {
    enable = true;
    settings = {
      spellcheck.languages = [ "en-US" "ru-RU" ];
      fonts = {
        default_family = fontUIName;
        default_size = "${fontUISize}pt";
      };
      zoom.default = 150;
    };
    extraConfig = (builtins.readFile
      (config.lib.base16.templateFile { name = "qutebrowser"; })) + ''
        config.load_autoconfig(False)
        c.tabs.padding = {"bottom": 5, "left": 5, "right": 5, "top": 5}
      '';
  };
}
