{...}:
{
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        nothing = {
          id = "C3MHNGS-T7A6ML3-NYNM34M-XRKNZHC-XPZ73VT-TM6NS35-27IUKBE-L7DPRAZ";
        };
        folders = {
          "/Users/anton/Obsidian/Anton" = {
            id = "obsidian-anton";
            devices = [ "nothing" ];
          };
        };
      };
    };
  };
}
