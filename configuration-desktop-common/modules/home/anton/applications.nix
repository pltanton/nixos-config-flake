{ pkgs, lib, ... }:

let
  dbeaver-x11 = pkgs.writeTextDir "share/applications/dbeaver-x11.desktop"
    (lib.generators.toINI { } {
      "Desktop Entry" = {
        Type = "Application";
        Exec = "env GDK_BACKEND=x11 env XCURSOR_SIZE=64 dbeaver";
        Terminal = false;
        Name = "dbeaver (X11)";
        Icon = "dbeaver";
        Comment = "SQL Integrated Development Environment";
        GenericName = "SQL Integrated Development Environment";
        Categories = "Development;";
      };
    });
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
in { home.packages = [ dbeaver-x11 firefox-nc ]; }
