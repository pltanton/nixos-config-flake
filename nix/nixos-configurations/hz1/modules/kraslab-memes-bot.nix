{ config, pkgs, secrets, inputs, ... }:

let botPackage = inputs.kraslab-memes-bot.packages.x86_64-linux.default;
in {
  systemd.services.kraslab-memes-bot = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "Start the Kraslab memes bot.";
    serviceConfig = {
      Restart = "always";
      Type = "simple";
      ExecStart = ''
        ${botPackage}/bin/kraslab-memes-bot
      '';
    };
    environment = {
      TG_TOKEN = secrets.kraslabMemesBot.botToken;
      MEME_CHANNEL_ID = "-1001498529908";
      MASTER_GROUP_ID = "-1001657100973";
    };
  };
}
