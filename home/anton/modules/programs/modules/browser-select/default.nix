{ pkgs, lib, ... }:
let
  script = pkgs.substituteAll {
    src = ./browser-select.sh;
    isExecutable = true;
  };
  domainsList = ./domain-list.csv;
  browser-select = pkgs.writeTextDir "share/applications/browser-select.desktop"
    (lib.generators.toINI { } {
      "Desktop Entry" = {
        Type = "Application";
        Exec =
          "env DOMAIN_LIST_FILE=${domainsList} DEFAULT_BROWSER=qutebrowser ${script} %u";
        Terminal = false;
        Name = "Select browser by regexp";
        Icon = "browser";
        Categories = "Network;WebBrowser";
        MimeType = "x-scheme-handler/http;x-scheme-handler/https";
      };
    });
in { home.packages = [ browser-select ]; }
