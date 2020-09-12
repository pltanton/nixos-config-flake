{ config, pkgs, secrets, ... }:

{

  systemd.services.quizanus = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "Start the QuizAnus platform.";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.quizanus}/bin/quizanus
      '';
    };
    environment = {
      DATABASE_JDBC_URL = "jdbc:postgresql://localhost:5432/quiz_bot";
      DATABASE_DRIVER = "org.postgresql.Driver";
      DATABASE_PASSWORD = "quiz_bot";
      DATABASE_USER = "quiz_bot";

      JAVA_HOME = "${pkgs.jre}";

      APP_API_TOKEN = secrets.quizanus.appApiToken;

      TELEGRAM_TOKEN = secrets.quizanus.telegramToken;
      TELEGRAM_NOTIFICATION_CHANNEL = secrets.quizanus.telegramNotificationChannel;
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts."quizanus.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://127.0.0.1:7000";
      };
    };
  };

  security.acme.certs = {
    "quizanus.kaliwe.ru".email = "plotnikovanton@gmail.com";
  };
}
