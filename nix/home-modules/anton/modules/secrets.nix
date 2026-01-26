{
  config,
  lib,
  ...
}: {
  sops = {
    defaultSopsFile = ../secrets.yaml;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };

  sops.secrets."perplexity-api-key" = {};

  programs.fish.interactiveShellInit = lib.mkAfter ''
    if test -f ${config.sops.secrets."perplexity-api-key".path}
      set -x PERPLEXITY_API_KEY (cat ${config.sops.secrets."perplexity-api-key".path})
    end
  '';
}
