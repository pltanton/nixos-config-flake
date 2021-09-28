{ pkgs, config, lib, inputs, ... }: {
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
        c.hints.chars = "aoeuidnths"

        c.colors.tabs.selected.odd.bg = "#e9ecef"
        c.colors.tabs.selected.odd.fg = "#000000"
        c.colors.tabs.selected.even.bg = "#e9ecef"
        c.colors.tabs.selected.even.fg = "#000000"

        config.bind(',,', "spawn --userscript qute-bitwarden -t -d 'wofi -d -i -p Bitwarden'")
      '';
  };

  home.packages = lib.mkIf config.wayland.windowManager.sway.enable [
    inputs.qbpm.defaultPackage.x86_64-linux
  ];
}
