{
  description = "Tutorial Flake accompanying vimconf talk.";

  # Input source for our derivation
  inputs = {
    nixpkgs.url = "github:DieracDelta/nixpkgs/jr/lean-lsp";
    flake-utils.url = "github:numtide/flake-utils";
    cornelis.url = "github:isovector/cornelis";

    vim-illuminate-src = {
      url = "github:RRethy/vim-illuminate";
      flake = false;
    };

    terraform-ls-src = {
      url = "github:hashicorp/terraform-ls";
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

    # 0.7.2 doesn't build for whatever reason
    # master does, so use that instead...
    neovim = { url = "github:neovim/neovim?dir=contrib"; };
    telescope-src = {
      url = "github:nvim-telescope/telescope.nvim";
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
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, neovim, nix2vim, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            neovim.overlay
            (import ./plugins.nix inputs)
            nix2vim.overlay
          ];
        };
        neovimConfig = pkgs.neovimBuilder {
          # Build with NodeJS
          withNodeJs = true;
          withPython3 = true;
          package = pkgs.neovim;
          imports = [
            ./modules/essentials.nix
            ./modules/lsp.nix
            ./modules/aesthetics.nix
            ./modules/telescope.nix
            ./modules/misc.nix
            ./modules/treesitter.nix
            ./modules/git.nix
            ./modules/wilder.nix
            ./modules/leap.nix
            ./modules/agda.nix
            ./modules/autopairs.nix
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
