{ config, lib, pkgs, ... }:

{
  services.apache-kafka = {
    enable = false;
    brokerId = 1;
    extraProperties = ''
      offsets.topic.replication.factor=1
      transaction.state.log.replication.factor=1
    '';
  };
  services.zookeeper = { enable = false; };

  virtualisation.oci-containers.containers = {
    zookeeper = {
      image = "bitnami/zookeeper:latest";
      ports = [ "2181:2181" ];
      # volumes = [ "zookeeper_data:/bitnami" ];
      environment = { ALLOW_ANONYMOUS_LOGIN = "yes"; };
      extraOptions = [ "--network=host" ];
    };
    # HASS container itself
    kafka = {
      image = "bitnami/kafka:latest";
      ports = [ "9092:9092" ];
      autoStart = true;
      # volumes = [ "kafka_data:/bitnami" ];
      dependsOn = [ "zookeeper" ];
      environment = {
        KAFKA_BROKER_ID = "1";
        KAFKA_LISTENERS = "PLAINTEXT://:9092";
        KAFKA_ADVERTISED_LISTENERS = "PLAINTEXT://127.0.0.1:9092";
        KAFKA_ZOOKEEPER_CONNECT = "localhost:2181";
        ALLOW_PLAINTEXT_LISTENER = "yes";
      };
      extraOptions = [ "--network=host" ];
    };
  };
}
