{
  pkgs,
  config,
  lib,
  ...
}: let
  rofi = pkgs.rofi.override {
    plugins = with pkgs; [rofi-emoji rofi-power-menu];
  };
  accent = config.catppuccin.accent;
  flavor = config.catppuccin.flavor;
in {
  catppuccin.rofi.enable = true;

  programs.rofi = {
    enable = true;
    package = rofi;
    font = "Inter 14";
    theme = lib.mkForce "minimal-catppuccin";
    extraConfig = {
      width = 30;
      line-margin = 10;
      lines = 6;
      columns = 2;

      display-emoji = "🫠";
      display-ssh = "";
      display-run = "";
      display-drun = "";
      display-window = "";
      display-combi = "";
      display-prompt = "";
      show-icons = false;
    };
  };

  xdg.configFile."rofi/themes/minimal-catppuccin.rasi".text = ''
    @import "catppuccin-${flavor}"

    * {
      accent: @${accent};
      surface: @surface0;
      outline: @surface2;
      on-surface: @text;
      on-surface-variant: @subtext0;
      primary: @accent;
      on-primary: @crust;
      secondary-container: @surface1;
      on-secondary-container: @text;
      error: @red;
      on-error: @crust;
      error-container: @maroon;
      on-error-container: @crust;
    }

    window {
      enabled: true;
      fullscreen: false;
      transparency: "real";
      cursor: "default";
      spacing: 0px;
      border: 2px;
      border-radius: 20px;
      location: center;
      anchor: center;
      width: 40%;
      background-color: @surface;
      border-color: @outline;
    }

    mainbox {
      enabled: true;
      orientation: vertical;
      children: [ "inputbar", "listbox" ];
      background-color: transparent;
    }

    inputbar {
      enabled: true;
      padding: 8px;
      margin: 10px;
      background-color: transparent;
      border-radius: 0px;
      orientation: horizontal;
      children: [ "entry" ];
    }

    entry {
      enabled: true;
      expand: true;
      width: 100%;
      padding: 8px;
      border-radius: 0px;
      background-color: transparent;
      text-color: @on-surface;
      cursor: text;
      placeholder: "Search";
      placeholder-color: @on-surface-variant;
    }

    listbox {
      spacing: 0px;
      padding: 0px 10px 10px 10px;
      background-color: transparent;
      orientation: vertical;
      children: [ "message", "listview" ];
    }

    listview {
      enabled: true;
      columns: 1;
      lines: 7;
      cycle: true;
      dynamic: true;
      scrollbar: false;
      layout: vertical;
      fixed-height: true;
      fixed-columns: true;
      spacing: 0px;
      padding: 0px;
      background-color: transparent;
      border: 0px;
    }

    scrollbar {
      border: 0px;
      background-color: transparent;
      handle-color: @primary;
      handle-width: 2px;
    }

    element {
      enabled: true;
      spacing: 8px;
      padding: 8px;
      border-radius: 10px;
      background-color: transparent;
      cursor: pointer;
    }

    element normal.normal {
      background-color: transparent;
      text-color: @on-surface;
    }

    element normal.active {
      background-color: @primary;
      text-color: @on-primary;
    }

    element normal.urgent {
      background-color: @error;
      text-color: @on-surface;
    }

    element selected.normal {
      background-color: @primary;
      text-color: @on-primary;
    }

    element selected.active {
      background-color: @primary;
      text-color: @on-primary;
    }

    element selected.urgent {
      background-color: @error;
      text-color: @on-error;
    }

    element alternate.normal,
    element alternate.active,
    element alternate.urgent {
      background-color: transparent;
      text-color: @on-surface;
    }

    element-icon {
      background-color: transparent;
      text-color: inherit;
      size: 28px;
      cursor: inherit;
    }

    element-text {
      background-color: transparent;
      text-color: inherit;
      cursor: inherit;
      vertical-align: 0.5;
      horizontal-align: 0.0;
    }

    message {
      background-color: transparent;
      border: 0px;
    }

    textbox {
      margin: 10px;
      padding: 8px;
      background-color: @secondary-container;
      text-color: @on-secondary-container;
      vertical-align: 0.5;
      horizontal-align: 0.5;
    }

    error-message {
      padding: 8px;
      background-color: @error-container;
      text-color: @on-error-container;
    }
  '';

  home.packages = with pkgs; [
    rofi-rbw
    wtype
  ];
}
