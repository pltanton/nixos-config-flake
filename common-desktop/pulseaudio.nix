{ pkgs, ... }: {
  nixpkgs.config.pulseaudio = true;
  hardware = {
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.support32Bit = true;
    # pulseaudio.extraConfig = ''
    #   load-module module-alsa-sink device=hw:0,7
    #   load-module module-bluetooth-policy auto_switch=2
    # '';
    pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];

    pulseaudio.tcp.anonymousClients.allowedIpRanges =
      [ "127.0.0.1" "192.168.0.0/16" ];
    pulseaudio.tcp.enable = true;
    pulseaudio.zeroconf.publish.enable = true;
  };
}
