_: {
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "laptop-only";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 1.75;
            position = "0,0";
          }
        ];
      }

      {
        profile.name = "with-dell-display";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 1.75;
            position = "0,0";
          }
          {
            criteria = "Dell Inc. DELL U2723QE JSJ91P3";
            status = "enable";
            scale = 1.75;
            position = "-2194,0";
          }
        ];
      }

      {
        profile.name = "dell-only-lid-closed";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Dell Inc. DELL U2723QE JSJ91P3";
            status = "enable";
            scale = 1.75;
            position = "0,0";
          }
        ];
      }
    ];
  };
}
