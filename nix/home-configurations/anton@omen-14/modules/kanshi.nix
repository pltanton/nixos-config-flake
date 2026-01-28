_: {
  services.kanshi = {
    enable = false;
    settings = [
      {
        profile.name = "laptop-only";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 2.0;
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
            scale = 2.0;
            # position = "3840,960"; # for 1.0 scaling
            position = "3200,600"; # for 1.2 scaling
            # position = "3072,528"; # for 1.25 scaling
          }
          {
            criteria = "Dell Inc. DELL U2723QE JSJ91P3";
            status = "enable";
            scale = 1.2;
            position = "0,0";
          }
        ];
      }
    ];
  };
}
