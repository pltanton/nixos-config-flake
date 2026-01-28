_: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = false;
    pulse.enable = true;

    wireplumber.enable = true;
  };

  hardware.pulseaudio.enable = false;
}
