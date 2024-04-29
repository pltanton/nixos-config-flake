{ pkgs, lib, ... }:

let
  firefox-nc = pkgs.writeTextDir "share/applications/firefox-nc.desktop"
    (lib.generators.toINI { } {
      "Desktop Entry" = {
        Categories = "Network;WebBrowser;";
        Type = "Application";
        Exec = "firefox -p nc %U";
        Terminal = false;
        Name = "Firefox (NeoCrypt)";
        Icon = "firefox";
        GenericName = "Web Browser";
      };
    });
in { home.packages = [ firefox-nc ]; }
