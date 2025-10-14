{pkgs, ...}: {
  programs.autobrowser = {
    enable = true;
    defaultCommand = "home";
    commands = {
      home = {
        cmd = ["open" "-a" "Zen" "ext+container:name=Personal&url={}"];
        queryEscape = true;
        # cmd = "open -a 'Google Chrome' {}";
      };
      work = {
        cmd = ["open" "-a" "Zen" "ext+container:name=Work&url={}"];
        queryEscape = true;
      };

      # google-meet.cmd = "open -na 'Google Chrome' --args '--app={}'";
    };
    rules = [
      {
        command = "work";
        matchers = [
          {
            type = "app";
            bundleId = "com.tinyspeck.slackmacgap";
          }
        ];
      }
      {
        command = "work";
        matchers = [
          {
            type = "app";
            bundleId = "com.cloudflare.1dot1dot1dot1.macos";
          }
        ];
      }
      {
        command = "work";
        matchers = [
          {
            type = "url";
            regex = ".*walletteam.*";
          }
        ];
      }
      {
        command = "work";
        matchers = [
          {
            type = "url";
            regex = ".*neocrypto.*";
          }
        ];
      }
      {
        command = "work";
        matchers = [
          {
            type = "url";
            regex = ".*jira.*";
          }
        ];
      }
    ];
  };
}
