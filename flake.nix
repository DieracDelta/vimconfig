{
  description = "Tutorial Flake accompanying vimconf talk.";

  # Input source for our derivation
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    cornelis.url = "github:isovector/cornelis";

    lldb-nix-fix = {
      url = "github:mstone/nixpkgs/darwin-fix-vscode-lldb";
    };

    vim-illuminate-src = {
      url = "github:RRethy/vim-illuminate";
      flake = false;
    };

    terraform-ls-src = {
      url = "github:hashicorp/terraform-ls";
      flake = false;
    };

    conjure-src = {
      url = "github:Olical/conjure";
      flake = false;
    };

    nil = {
      url = "github:oxalica/nil";
    };

    nix2vim = {
      url = "github:gytis-ivaskevicius/nix2vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plenary-nvim-src = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };

    telescope-src = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };

    lsp-config-src = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };

    wilder-nvim-src = {
      url = "github:gelguy/wilder.nvim";
      flake = false;
    };
    dracula-nvim = {
      url = "github:Mofiqul/dracula.nvim";
      flake = false;
    };
    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    comment-nvim-src = {
      url = "github:numToStr/Comment.nvim";
      flake = false;
    };
    blamer-nvim-src = {
      url = "github:APZelos/blamer.nvim";
      flake = false;
    };
    telescope-ui-select-src = {
      url = "github:nvim-telescope/telescope-ui-select.nvim";
      flake = false;
    };
    rust-tools-src = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };
    fidget-src = {
      url = "github:j-hui/fidget.nvim";
      flake = false;
    };
    neogen-src = {
      url = "github:danymat/neogen";
      flake = false;
    };
    which-key-src = {
      url = "github:folke/which-key.nvim?ref=bd4411a2ed4dd8bb69c125e339d837028a6eea71";
      flake = false;
    };
    conceal-src = {
      url = "github:ticki/rust-cute-vim";
      flake = false;
    };
    colorizer-src = {
      url = "github:powerman/vim-plugin-AnsiEsc";
      flake = false;
    };
    guess-indent-src = {
      url = "github:NMAC427/guess-indent.nvim";
      flake = false;
    };
    leap-src = {
      url = "github:ggandor/leap.nvim";
      flake = false;
    };
    nvim-autopairs-src = {
      url = "github:windwp/nvim-autopairs";
      flake = false;
    };

    nvim-ufo-src = {
      url = "github:kevinhwang91/nvim-ufo";
      flake = false;
    };

    nvim-async-src = {
      url = "github:kevinhwang91/promise-async";
      flake = false;
    };

    # lsp_lines-src = {
    #   url = "git+https://git.sr.ht/~whynothugo/lsp_lines.nvim";
    #   flake = false;
    # };

    markid-src = {
      url = "github:David-Kunz/markid";
      flake = false;
    };

    copilot-lua-src = {
      url = "github:zbirenbaum/copilot.lua";
      flake = false;
    };

    copilot-cmp-src = {
      url = "github:zbirenbaum/copilot-cmp";
      flake = false;
    };

    copilot-vim-src = {
      url = "github:github/copilot.vim";
      flake = false;
    };

    codium-nvim-src = {
      url = "github:jcdickinson/codeium.nvim";
      flake = false;
    };

    neural-src = {
      url = "github:dense-analysis/neural";
      flake = false;
    };

    nui-nvim-src = {
      url = "github:muniftanjim/nui.nvim";
      flake = false;
    };

    significant-nvim-src = {
      url = "github:elpiloto/significant.nvim";
      flake = false;
    };

    chatgpt-nvim-src = {
      url = "github:jackMort/ChatGPT.nvim";
      flake = false;
    };

    coq-lsp = {
      type = "git";
      url = "https://github.com/r-muhairi/coq-lsp";
      ref = "feat/flake-parts";
      submodules = true;
    };

    nvim-dap-src = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };



    # coq-lsp = {
    #   url = "github:r-muhairi/coq-lsp?ref=48bfb06558816861ca049b771b93f761e5e27fba&submodules=1";
    #   flake = true;
    # };

  };

  outputs = inputs@{ self, flake-utils, nixpkgs, nix2vim, coq-lsp, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (import ./plugins.nix inputs)
            nix2vim.overlay
            (prev: final:
              {
                coq-lsp = coq-lsp.packages.aarch64-darwin.default;
              }
            )
          ];
        };
        neovimConfig = pkgs.neovimBuilder {
        #  # Build with NodeJS
          withNodeJs = true;
          withPython3 = true;
          package = nixpkgs.legacyPackages.${system}.neovim-unwrapped;
          imports = [
            ./modules/essentials.nix
            ./modules/lsp.nix
            ./modules/aesthetics.nix
            ./modules/telescope.nix
            ./modules/misc.nix
            ./modules/treesitter.nix
            ./modules/git.nix
            ./modules/wilder.nix
            # ./modules/leap.nix
            ./modules/agda.nix
            #./modules/autopairs.nix
            # TODO uncomment when
            # https://github.com/Olical/conjure/issues/401
            # this will be quite useful
            # ./modules/repl.nix
          ];
        };
      in
      {
        # The package built by `nix build .`
        defaultPackage = neovimConfig;
        # The app run by `nix run .`
        apps.defaultApp = {
          type = "app";
          program = "${neovimConfig}/bin/nvim";
        };
      });
}
