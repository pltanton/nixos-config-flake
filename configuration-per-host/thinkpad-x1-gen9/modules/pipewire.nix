{ pkgs, lib, config, ... }: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };

  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = false;
  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]",
        ["bluez5.codecs"] = "[ sbc sbc_xq aac aptx aptx_hd aptx_ll ]",
        ["bluez5.auto-connect"] = "[ hfp_hf hsp_hs a2dp_sink ]"
      }
    '';
  };

}
