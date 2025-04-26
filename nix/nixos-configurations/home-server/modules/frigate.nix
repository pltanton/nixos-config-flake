{
  pkgs,
  config,
  lib,
  ...
}: let
  consts = import ../constants.nix;
  storageDir = "${consts.storeMountPoint}/motioneye";
  settings = pkgs.writeText "settings.yaml" (lib.generators.toYAML {} {
    auth.enabled = true;
    tls.enabled = false;
    detect.enabled = true;

    mqtt = {
      enabled = true;
      host = "172.17.0.1";
      user = "{FRIGATE_MQTT_USER}";
      password = "{FRIGATE_MQTT_PASS}";
    };
    record = {
      enabled = true;
      retain = {
        mode = "all";
        days = 128;
      };
    };
    detectors = {
      ov = {
        type = "openvino";
        device = "CPU";
      };
    };
    model = {
      width = 300;
      height = 300;
      input_tensor = "nhwc";
      input_pixel_format = "bgr";
      path = "/openvino-model/ssdlite_mobilenet_v2.xml";
      labelmap_path = "/openvino-model/coco_91cl_bkgr.txt";
    };

    go2rtc = {
      streams = {
        outdoor_camera = [
          # "rtsp://{FRIGATE_OUTDOOR_USER}:{FRIGATE_OUTDOOR_PASSWORD}@{FRIGATE_OUTDOOR_IP}/stream1#audio=aac#video=copy"
          "tapo://{FRIGATE_TAPO_ACCOUNT_PASSWORD}@{FRIGATE_OUTDOOR_IP}"
        ];
      };
    };
    cameras = {
      outdoor_camera = {
        enabled = true;
        onvif = {
          host = "192.168.0.89";
          port = "2020";
          user = "{FRIGATE_OUTDOOR_USER}";
          password = "{FRIGATE_OUTDOOR_PASSWORD}";
        };

        ffmpeg = {
          output_args.record = "preset-record-generic-audio-aac";
          inputs = [
            {
              path = "rtsp://127.0.0.1:8554/outdoor_camera?video&audio";
              roles = ["record"];
            }
          ];
        };
      };
    };
  });
in {
  services.caddy.virtualHosts."frigate.pltanton.dev".extraConfig = ''
    reverse_proxy :8971
  '';

  sops.secrets."frigate-env" = {};
  virtualisation.oci-containers.containers.frigate = {
    image = "ghcr.io/blakeblackshear/frigate:stable";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "frigate:/config"
      "${settings}:/config/config.yml"
      "${storageDir}:/media/frigate"
    ];
    extraOptions = [
      "--device=/dev/kfd"
      "--device=/dev/dri"
    ];
    ports = ["8971:8971" "8554:8554" "8555:8555"];
    environmentFiles = [config.sops.secrets."frigate-env".path];
  };
}
