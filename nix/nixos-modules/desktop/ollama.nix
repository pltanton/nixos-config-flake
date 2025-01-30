_: {
  services.ollama = {
    enable = true;
    loadModels = [
      "qwen2.5-coder:7b"
      "deepseek-coder-v2"
      "llama3.1:8b"
    ];
  };
}
