{ pkgs, lib, ... }:

let
  dbeaver-x11 = pkgs.writeTextDir "share/applications/dbeaver-x11.desktop"
    (lib.generators.toINI { } {
      "Desktop Entry" = {
        Type = "Application";
        Exec = "env GDK_BACKEND=x11 dbeaver";
        Terminal = false;
        Name = "dbeaver (X11)";
        Icon = "dbeaver";
        Comment = "SQL Integrated Development Environment";
        GenericName = "SQL Integrated Development Environment";
        Categories = "Development;";
      };
    });
  firefox-ozon = pkgs.writeTextDir "share/applications/firefox-ozon.desktop"
    (lib.generators.toINI { } {
      "Desktop Entry" = {
        Categories = "Network;WebBrowser;";
        Type = "Application";
        Exec = "firefox -p ozon %U";
        Terminal = false;
        Name = "Firefox (OZON)";
        Icon = "firefox";
        GenericName = "Web Browser";
      };
    });
  teams-chromium = pkgs.writeTextDir "share/applications/teams-chromium.desktop"
    (lib.generators.toINI { } {
      "Desktop Entry" = {
        Categories = "Network;";
        Type = "Application";
        Exec = "chromium --app=https://teams.microsoft.com";
        Terminal = false;
        Name = "Chromium (Microsoft Teams)";
        Icon = "teams";
        GenericName = "Web Browser";
      };
    });
in { home.packages = [ dbeaver-x11 firefox-ozon teams-chromium ]; }
