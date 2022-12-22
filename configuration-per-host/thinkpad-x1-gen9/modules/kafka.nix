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
    # zookeeper = {
    #   image = "bitnami/zookeeper:latest";
    #   ports = [ "2181:2181" ];
    #   # volumes = [ "zookeeper_data:/bitnami" ];
    #   environment = { ALLOW_ANONYMOUS_LOGIN = "yes"; };
    #   volumes = [ "zookeeper_data:/bitnami/zookeeper" ];
    # };
    # # HASS container itself
    # kafka = {
    #   image = "bitnami/kafka:latest";
    #   ports = [ "9092:9092" ];
    #   autoStart = true;
    #   # volumes = [ "kafka_data:/bitnami" ];
    #   dependsOn = [ "zookeeper" ];
    #   volumes = [ "kafka_data:/bitnami/kafka" ];
    #   environment = {
    #     KAFKA_BROKER_ID = "1";
    #     KAFKA_LISTENERS = "DNS://:29092,LOCAL_IP://:9092";
    #     KAFKA_ADVERTISED_LISTENERS =
    #       "DNS://kafka.dns.podman:29092,LOCAL_IP://127.0.0.1:9092";
    #     KAFKA_LISTENER_SECURITY_PROTOCOL_MAP =
    #       "DNS:PLAINTEXT,LOCAL_IP:PLAINTEXT";
    #     KAFKA_ZOOKEEPER_CONNECT = "zookeeper.dns.podman:2181";
    #     KAFKA_INTER_BROKER_LISTENER_NAME = "LOCAL_IP";
    #     ALLOW_PLAINTEXT_LISTENER = "yes";
    #     KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR = "1";
    #   };
    # };

    # kafka-ui = {
    #   image = "provectuslabs/kafka-ui:latest";
    #   ports = [ "9080:8080" ];
    #   environment = {
    #     KAFKA_CLUSTERS_0_NAME = "local";
    #     KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS = "kafka.dns.podman:29092";
    #   };
    # };
  };
}
