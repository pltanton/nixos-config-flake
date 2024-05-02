pkgs: with pkgs; {
  float-preview = pkgs.vimUtils.buildVimPlugin {
    name = "float-preview";
    src = pkgs.fetchFromGitHub {
      owner = "ncm2";
      repo = "float-preview.nvim";
      rev = "c5431b6d9bd4a8002f1a3eec42e9458ef4453ff3";
      sha256 = "0ylrp0pmg822m7zp7dhyhmb05zbiy4gbq40l4whs249v0v4s9vyd";
    };
  };

  vim-misc = pkgs.vimUtils.buildVimPlugin {
    name = "vim-misc";
    src = pkgs.fetchFromGitHub {
      owner = "xolox";
      repo = "vim-misc";
      rev = "3e6b8fb6f03f13434543ce1f5d24f6a5d3f34f0b";
      sha256 = "0rd9788dyfc58py50xbiaz5j7nphyvf3rpp3yal7yq2dhf0awwfi";
    };
  };

  autocomplete-flow = pkgs.vimUtils.buildVimPlugin {
    name = "autocomplete-flow";
    src = pkgs.fetchFromGitHub {
      owner = "wokalski";
      repo = "autocomplete-flow";
      rev = "5d6fb85866ec2edf1eecde823efd2bf471640f5d";
      sha256 = "189g324cb54cks447n40fjci89l4smbq0i34qawrjmg0ng82hmf1";
    };
  };

  deoplete-clang2 = pkgs.vimUtils.buildVimPlugin {
    name = "deoplete-clang2";
    src = pkgs.fetchFromGitHub {
      owner = "tweekmonster";
      repo = "deoplete-clang2";
      rev = "8877dda0a474824977443a112cf0f4fa465e97f6";
      sha256 = "1k8c2ph04fj2c5dqm6ky8jhr8g2srdpafapy102n46nksyyx0yhf";
    };
  };

  vim-jsx = pkgs.vimUtils.buildVimPlugin {
    name = "vim-jsx";
    src = pkgs.fetchFromGitHub {
      owner = "mxw";
      repo = "vim-jsx";
      rev = "52ee8bb9f4b53e9bcb38c95f9839ec983bcf7f9d";
      sha256 = "0widi2gnxvdfzhhn0digcjqb28npxv0dpm3l37ijklcfxbc16hzi";
    };
  };

  oceanic-next = pkgs.vimUtils.buildVimPlugin {
    name = "oceanic-next";
    src = pkgs.fetchFromGitHub {
      owner = "mhartington";
      repo = "oceanic-next";
      rev = "021c281ba959d4ba91bdf7dca4cae47a35789386";
      sha256 = "1vvjll44596905m9yxp33ac9sx2nq8l3kli2wjxi82hdah3xc3sm";
    };
  };

  kotlin = pkgs.vimUtils.buildVimPlugin {
    name = "kotlin";
    src = pkgs.fetchFromGitHub {
      owner = "udalov";
      repo = "kotlin-vim";
      rev = "cf0f4814b9500f16c42b799393fbb621c308f2a0";
      sha256 = "18p09nfh3a7ccjqf73rffyla09g4ikfsc1zmxn9g8hs7f5x8ljj6";
    };
  };

  coc-nvim = let
    version = "0.0.67";
    index_js = fetchzip {
      url = "https://github.com/neoclide/coc.nvim/releases/download/v${version}/coc.tar.gz";
      sha256 = "0cqgrfyaq9nck1y6mb63gmwgdrxqzgdgns5gjshpp1xzfq6asrqj";
    };
  in
    pkgs.vimUtils.buildVimPlugin {
      pname = "coc-nvim";
      version = "2019-05-23";
      src = fetchFromGitHub {
        owner = "neoclide";
        repo = "coc.nvim";
        rev = "86f938db42dd071257a16c6f500c7d7a8dd8f34d";
        sha256 = "0p2w7brlvhsxcvq199a4x59w6zmm3m4mhnr52rm660dydrbvd8gl";
      };
      postInstall = ''
        mkdir -p $out/share/vim-plugins/coc-nvim/build
        cp ${index_js}/index.js $out/share/vim-plugins/coc-nvim/build/
      '';
    };
}
