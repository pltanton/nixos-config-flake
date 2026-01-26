{pkgs, ...}: {
  programs.lazyvim = {
    enable = true;

    extras = {
      lang = {
        nix = {
          enable = true;
          installDependencies = true; # Install ruff
        };
        python = {
          enable = true;
          installDependencies = true; # Install ruff
        };
        go = {
          enable = true;
          installDependencies = true; # Install gopls, gofumpt, etc.
        };
      };
    };

    plugins = {
      colorscheme = ''
        return {
          "catppuccin/nvim",
          opts = { flavour = "mocha" },
        }
      '';

      conform = ''
        return {
          "stevearc/conform.nvim",
          opts = {
            formatters_by_ft = {
              nix = { "alejandra" },
            },
          }
        }
      '';

      parrot = ''
        return {
          "frankroeder/parrot.nvim",
          dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
          opts = {
            providers = {
              perplexity = {
                name = "perplexity",
                api_key = os.getenv("PERPLEXITY_API_KEY"),
                endpoint = "https://api.perplexity.ai/chat/completions",
                models = { "sonar-pro", "llama-3.1-sonar-large-128k-online" },
              },
            },
          },
          keys = {
            { "<leader>aa", "<cmd>PrtChatNew<cr>", desc = "AI Chat" },
            { "<leader>ar", "<cmd>PrtRewrite<cr>", desc = "AI Rewrite", mode = { "n", "v" } },
            { "<leader>ae", "<cmd>PrtEdit<cr>", desc = "AI Edit", mode = { "n", "v" } },
            { "<leader>aA", "<cmd>PrtAppend<cr>", desc = "AI Append", mode = { "n", "v" } },
            { "<leader>ap", "<cmd>PrtPrepend<cr>", desc = "AI Prepend", mode = { "n", "v" } },
            { "<C-g>", mode = { "n", "v" }, desc = "AI actions" },
          },
        }
      '';
    };

    # Additional packages (optional)
    extraPackages = with pkgs; [
      nixd # Nix LSP
      alejandra # Nix formatter
      statix
    ];

    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [
      wgsl # WebGPU Shading Language
      templ # Go templ files
    ];
  };
}
