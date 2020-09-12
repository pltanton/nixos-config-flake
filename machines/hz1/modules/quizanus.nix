{ config, pkgs, ... }:

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

      APP_API_TOKEN = "JBskx2dJ39yVaCrR";

      TELEGRAM_TOKEN = "1047800889:AAEAbpGBU3NMNI868XtImr2THUTfkuw3xfY";
      TELEGRAM_NOTIFICATION_CHANNEL = "-1001335827237";
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
