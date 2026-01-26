{pkgs, ...}: {
  services.ollama = {
    enable = true;
    host = "0.0.0.0";
    loadModels = [
      "qwen3:1.7b"
      "qwen3:4b"
      "llama3.2:3b"
      "gemma3:4b"
      "gemma3:1b"
    ];
    package = pkgs.ollama-rocm;
    rocmOverrideGfx = "9.0.0";
    environmentVariables = {
      OLLAMA_ORIGINS = "moz-extension://*,chrome-extension://*,safari-web-extension://*";
      OLLAMA_MAX_LOADED_MODELS = "1";
      OLLAMA_NUM_PARALLEL = "1";
      HIP_VISIBLE_DEVICES = "0";
      ROCR_VISIBLE_DEVICES = "0";
    };
  };
}
