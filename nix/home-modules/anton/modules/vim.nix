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
