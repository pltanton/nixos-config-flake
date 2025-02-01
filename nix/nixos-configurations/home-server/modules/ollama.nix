{pkgs, ...}: {
  nixpkgs.config.rocmSupport = true;
  services = {
    ollama = {
      enable = false;
      # package = pkgs.ollama-rocm;
      models = "/media/store/ollama";
      loadModels = [
        # "llama3.1:8b"
        # "qwen2.5-coder:7b"
      ];
    };

    open-webui = {
      package = pkgs.stable.open-webui;
      enable = false;
      port = 11435;
    };
  };
}
