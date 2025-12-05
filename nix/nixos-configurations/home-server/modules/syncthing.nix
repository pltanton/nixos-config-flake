{config, ...}: {
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    settings = {
      devices = {
        nothing = {
          id = "C3MHNGS-T7A6ML3-NYNM34M-XRKNZHC-XPZ73VT-TM6NS35-27IUKBE-L7DPRAZ";
          autoAcceptFolders = true;
        };
        mac = {
          id = "YCURHN3-DMEECGJ-ZYNVFYE-PED2TMP-QGWT642-PMNTG5W-HC4BX2M-UCDLXQE";
          autoAcceptFolders = true;
        };
      };
    };
  };
}
