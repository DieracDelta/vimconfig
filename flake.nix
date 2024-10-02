{
  description = "Neovim config";

  inputs = {
    rustaceanvim-src = {
      url = "github:mrcjkb/rustaceanvim";
      flake = false;
    };
     gitlinker-nvim-src = {
      url = "github:linrongbin16/gitlinker.nvim";
      flake = false;
    };

    ferris-nvim-src = {
      url = "github:vxpm/ferris.nvim";
      flake = false;
    };

    molten-nvim-src = {
      url = "github:benlubas/molten-nvim";
      flake = false;
    };
    typst-vim-src = {
      url = "github:kaarmu/typst.vim";
      flake = false;
    };
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    cornelis.url = "github:isovector/cornelis";

    vim-circom-syntax-src = {
      url = "github:iden3/vim-circom-syntax";
      flake = false;
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
    gruvbox-nvim-src = {
      url = "github:ellisonleao/gruvbox.nvim";
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
    fidget-src = {
      url = "github:j-hui/fidget.nvim/legacy";
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

    # copilot-vim-src = {
    #   url = "github:github/copilot.vim";
    #   flake = false;
    # };
    #

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

    # chatgpt-nvim-src = {
    #   url = "github:jackMort/ChatGPT.nvim";
    #   flake = false;
    # };

    nvim-dap-src = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };

    nvim-dap-ui-src = {
      url = "github:rcarriga/nvim-dap-ui";
      flake = false;
    };

    nvim-dap-virtual-text-src = {
      url = "github:theHamsta/nvim-dap-virtual-text";
      flake = false;
    };

    telescope-dap-nvim-src = {
      url = "github:nvim-telescope/telescope-dap.nvim";
      flake = false;
    };

    cmp-dap-src = {
      url = "github:rcarriga/cmp-dap";
      flake = false;
    };

    # coq-lsp = {
    #   url = "github:r-muhairi/coq-lsp?ref=48bfb06558816861ca049b771b93f761e5e27fba&submodules=1";
    #   flake = true;
    # };
    node-type-nvim-src = {
      url = "github:roobert/node-type.nvim";
      flake = false;
    };

    floating-input-src = {
      url = "github:liangxianzhe/floating-input.nvim";
      flake = false;
    };

    ts-node-action-src = {
      url = "github:CKolkey/ts-node-action";
      flake = false;
    };

    nvim-trailblazer-src = {
      url = "github:LeonHeidelbach/trailblazer.nvim";
      flake = false;
    };

    nvim-treesitter-src = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };

    nvim-matchup-src = {
      url = "github:andymass/vim-matchup";
      flake = false;
    };

    quick-scope-src = {
      url = "github:unblevable/quick-scope";
      flake = false;
    };

    telescope-dapzzzz-src = {
      url = "github:HUAHUAI23/telescope-dapzzzz";
      flake = false;
    };

    yazi-nvim-src = {
      url = "github:mikavilpas/yazi.nvim";
      flake = false;
    };
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs {
          inherit system;
          overlays = [
            (import ./plugins.nix inputs)
            (prev: final: { })
          ];
        });
        pluginList = with pkgs; [
          # essentials
          which-key

          # aesthetics
          gruvbox-nvim
          vimPlugins.lualine-nvim
          vimPlugins.tabline-nvim
          vimPlugins.nvim-web-devicons

          # telescope
          telescope-nvim
          vimPlugins.telescope-file-browser-nvim
          telescope-ui-select
          yazi-nvim

          # github
          gitlinker-nvim

          # misc
          vimPlugins.surround-nvim
          vimPlugins.undotree
          parinfer-rust-nvim
          colorizer

          # git
          vimPlugins.neogit
          blamer-nvim
          vimPlugins.gitsigns-nvim

          # autopairs
          nvim-autopairs

          # lsp
          vimPlugins.nvim-nio # async-io
          vimPlugins.rust-vim # for formatting
          vimPlugins.image-nvim
          vimPlugins.typescript-tools-nvim
          typst-vim
          vimPlugins.vim-ormolu # haskell
          vimPlugins.haskell-tools-nvim # haskell
          cmp-nvim-lsp # completion
          nvim-cmp # completion
          vimPlugins.cmp-vsnip # completion
          cmp-buffer # completion
          vimPlugins.lsp_signature-nvim
          vimPlugins.lspkind-nvim
          lsp-config
          plenary-nvim
          vimPlugins.popup-nvim
          vimPlugins.vim-vsnip
          vimPlugins.vim-vsnip-integ
          vimPlugins.friendly-snippets
          ferris-nvim
          rustaceanvim
          vimPlugins.crates-nvim
          fidget
          vimPlugins.trouble-nvim
          copilot-lua
          copilot-cmp
          node-type-nvim
          floating-input

          # treesitter
          nvim-async
          nvim-ufo
          comment-nvim
          vimPlugins.nvim-treesitter-context
          vimPlugins.nvim-treesitter-textobjects
          ((pkgs.vimPlugins.nvim-treesitter.overrideAttrs (oldAttrs: {
            src = pkgs.nvim-treesitter-src;
          }) ).withAllGrammars)
          vimPlugins.nvim-ts-autotag
          vimPlugins.rainbow-delimiters-nvim
          vim-illuminate
          markid
          ts-node-action

        ];
        luaModules =  [
          "essentials"
          "aesthetics"
          "telescope"
          "github"
          "misc"
          "treesitter"
          "git"
          "autopairs"
          "lsp"
        ];
        luaRequire = module: builtins.readFile (builtins.toString ./lua_modules + "/${module}.lua");
        pluginAttrSet = map (x: { plugin = x; }) pluginList;
        orig_config = pkgs.neovimUtils.makeNeovimConfig {
          withNodeJs = true;
          withRuby = true;
          withPython3 = true;
          plugins = pluginAttrSet;
        };
        config = orig_config
        // {
          luaRcContent =
            builtins.concatStringsSep "\n" (map luaRequire luaModules)
          ;
          wrapperArgs = ["--suffix" "PATH" ":" "${pkgs.lib.makeBinPath /* great place for pipe operator */ (with pkgs;[ ripgrep git terraform-ls lua-language-server clang-tools myRSetup nodejs nodePackages.vscode-json-languageserver ripgrep fd])}"];
        };
        myNeovim =
          pkgs.wrapNeovimUnstable
            (pkgs.neovim-unwrapped.overrideAttrs (oldAttrs: {
              buildInputs = oldAttrs.buildInputs ++ (with pkgs; [ tree-sitter ]);
            }))
            config;
      in
      {
        defaultPackage = myNeovim;
        apps.defaultApp = {
          type = "app";
          program = "${myNeovim}/bin/nvim";
        };
        packages.neovim = myNeovim;
      });
}
