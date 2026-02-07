_: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = false;
    pulse.enable = true;

    wireplumber.enable = true;

    #   extraConfig.pipewire."90-bt-broadcast" = {
    #     "context.modules" = [
    #       {
    #         name = "libpipewire-module-combine-stream";
    #         args = {
    #           "combine.mode" = "sink";
    #           "node.name" = "bt-broadcast";
    #           "node.description" = "A combined sink to all bluetooth devices";
    #           "combine.latency-compensate" = false;
    #           "combine.props" = {
    #             "audio.position" = [ "FL" "FR" ];
    #           };
    #           "stream.props" = { };
    #           "stream.rules" = [
    #             {
    #               matches = [
    #                 {
    #                   "node.name" = "~bluez_output.*";
    #                   "media.class" = "Audio/Sink";
    #                 }
    #               ];
    #               actions = {
    #                 "create-stream" = { };
    #               };
    #             }
    #           ];
    #         };
    #       }
    #     ];
    #   };
  };

  hardware.pulseaudio.enable = false;
}
