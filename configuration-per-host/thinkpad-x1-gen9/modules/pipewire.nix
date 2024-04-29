{ pkgs, lib, config, ... }: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;

    # wireplumber.configPackages = [
    #   (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
    #     bluez_monitor.properties = {
    #       ["bluez5.enable-sbc-xq"] = true,
    #       ["bluez5.enable-msbc"] = true,
    #       ["bluez5.enable-hw-volume"] = true,
    #       ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]",
    #       ["bluez5.autoswitch-profile"] = true
    #   '')
    #   (pkgs.writeTextDir "share/wireplumber/policy.lua.d/11-bluetooth-polity.lua" ''
    #     bluetooth_policy.policy["media-role.use-headset-profile"] = true
    #   '')
    # ];
  };

  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = false;
  programs.noisetorch.enable = false;
}
