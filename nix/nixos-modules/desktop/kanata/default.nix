_: {
  hardware.uinput.enable = true;
  services.kanata = {
    enable = true;
    keyboards = {
      default = {
        config = builtins.readFile ./laptop.kbd;
        devices = ["/dev/input/by-path/platform-i8042-serio-0-event-kbd"];
        extraDefCfg = ''
          process-unmapped-keys yes
          concurrent-tap-hold yes
        '';
      };
    };
  };
}
