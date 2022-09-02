{ pkgs, config, ... }:
let
  configDir = "${config.xdg.configHome}/wofi";
  styleFile = "${configDir}/style.css";
  configFile = "${configDir}/config";
  toRgba = let t = config.lib.base16.theme;
  in col: opacity:
  "rgba(${t."base${col}-rgb-r"},${t."base${col}-rgb-g"},${
    t."base${col}-rgb-b"
  },${opacity})";
in {
  home.packages = with pkgs; [ wofi ];

  home.file."${configFile}".text = with config.lib.base16.theme; ''
    insensitive=true
    key_expand=Tab
  '';

  home.file."${styleFile}".text = with config.lib.base16.theme; ''
    window {
      background-color: #${base00-hex};
      color: #${base05-hex};
      font-size: 28px;
      margin: 10px;
      opacity: 0.95;
    }

    #inner-box {
      margin: 10px;
      border: none;
      background-color: #${base00-hex};
    }

    #outer-box {
      margin: 10px;
      border: none;
      background-color: #${base00-hex};
    }

    #entry {
      background-color: #${base00-hex};
    }

    /* #entry:nth-child(odd) {
      background-color: #${base00-hex};
    }

    #entry:nth-child(even) {
      background-color: #${base01-hex};
    } */

    #entry:selected {
      background-color: #${base02-hex};
    }

    #input {
      background-color: #${base01-hex};
      color: #${base04-hex};
      margin: 10px;
      border: none;
    }
  '';
}
