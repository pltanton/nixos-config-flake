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
    mqtt.enabled = false;
    tls.enabled = false;
    detect.enabled = true;
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
    cameras = {
      outdoor = {
        enabled = true;
        onvif = {
          host = "192.168.0.89";
          port = "2020";
          user = "{FRIGATE_OUTDOOR_USER}";
          password = "{FRIGATE_OUTDOOR_PASSWORD}";
        };
        ffmpeg.inputs = [
          {
            path = "rtsp://{FRIGATE_OUTDOOR_USER}:{FRIGATE_OUTDOOR_PASSWORD}@{FRIGATE_OUTDOOR_IP}/stream1";
            roles = ["record"];
          }
          {
            path = "rtsp://{FRIGATE_OUTDOOR_USER}:{FRIGATE_OUTDOOR_PASSWORD}@{FRIGATE_OUTDOOR_IP}/stream2";
            roles = ["detect"];
          }
        ];
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
    ports = ["8971:8971"];
    environmentFiles = [config.sops.secrets."frigate-env".path];
  };
}
