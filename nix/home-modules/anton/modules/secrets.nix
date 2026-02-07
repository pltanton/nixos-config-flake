{
  config,
  lib,
  ...
}: {
  # sops.secrets."perplexity-api-key" = {};
  sops.secrets."gmail-token" = {};

  # programs.fish.interactiveShellInit = lib.mkAfter ''
  #   if test -f ${config.sops.secrets."perplexity-api-key".path}
  #     set -x PERPLEXITY_API_KEY (cat ${config.sops.secrets."perplexity-api-key".path})
  #   end
  # '';
}
