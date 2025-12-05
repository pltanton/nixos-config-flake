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
        home-server = {
          id = "P6SLZ5L-4W5LDZZ-IPBLRKE-RYWEMLL-FEULFQU-GSL6GMF-C6NHG3D-DD5GVQB";
        };
      };
      folders = {
        "/Users/anton/Obsidian/Anton" = {
          id = "obsidian-anton";
          devices = [ "nothing" "home-server" ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "31536000";
            };
          };
        };

        "/Users/anton/Obsidian/Family" = {
          id = "obsidian-family";
          devices = [ "home-server" ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "31536000";
            };
          };
        };
      };
    };
  };
}
