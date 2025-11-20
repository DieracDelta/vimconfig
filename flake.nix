{
  description = "Neovim config";

  inputs = {
    nixfmt.url = "github:nixos/nixfmt";
    mnw.url = "github:Gerg-L/mnw";
    blamer-nvim-src.url = "github:psjay/blamer.nvim";
    blamer-nvim-src.flake = false;
    colorful-winsep-nvim-src = {
      url = "github:nvim-zh/colorful-winsep.nvim";
      flake = false;
    };

    lze-flk = {
      url = "github:BirdeeHub/lze";
    };

    rust-owl = {
      url = "github:mrcjkb/rustowl-flake";
    };

    lzextras-flk = {
      url = "github:BirdeeHub/lzextras";
    };

    symbols-nvim-src = {
      url = "github:oskarrrrrrr/symbols.nvim";
      flake = false;
    };

    coqtail-src = {
      url = "github:whonore/Coqtail";
      flake = false;
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      flake = true;
    };
    ghostty-nvim-src = {
      url = "github:isak102/ghostty.nvim";
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
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
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

    telescope-src = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };

    telescope-live-grep-args-src = {
      url = "github:nvim-telescope/telescope-live-grep-args.nvim";
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
    # nvim-cmp = {
    #   url = "github:hrsh7th/nvim-cmp";
    #   flake = false;
    # };
    # cmp-nvim-lsp = {
    #   url = "github:hrsh7th/cmp-nvim-lsp";
    #   flake = false;
    # };
    # cmp-buffer = {
    #   url = "github:hrsh7th/cmp-buffer";
    #   flake = false;
    # };
    comment-nvim-src = {
      url = "github:numToStr/Comment.nvim";
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

    # copilot-lua-src = {
    #   url = "github:zbirenbaum/copilot.lua";
    #   flake = false;
    # };

    # copilot-cmp-src = {
    #   url = "github:zbirenbaum/copilot-cmp";
    #   flake = false;
    # };

    # copilot-vim-src = {
    #   url = "github:github/copilot.vim";
    #   flake = false;
    # };
    #

    neural-src = {
      url = "github:dense-analysis/neural";
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

    # cmp-dap-src = {
    #   url = "github:rcarriga/cmp-dap";
    #   flake = false;
    # };

    coq-lsp-nvim-src = {
      url = "github:DieracDelta/coq-lsp.nvim";
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

  };

  outputs =
    inputs@{
      self,
      flake-utils,
      nixpkgs,
      neovim-nightly-overlay,
      lze-flk,
      lzextras-flk,
      rust-owl,
      mnw,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs =
          if system != "x86_64-linux" then
            (import nixpkgs {
              localSystem = {
                inherit system;
                gcc.arch = "-march=apple-m1";
                gcc.mtune = "-march=apple-m1";
              };
              crossSystem = {
                inherit system;
                gcc.arch = "-march=apple-m1";
                gcc.mtune = "-march=apple-m1";
              };
              overlays = [
                (import ./plugins.nix inputs)
                lze-flk.overlays.default
                lzextras-flk.overlays.default
                (prev: final: {
                  nil = inputs.nil.packages.${system}.nil;
                  nixfmt = inputs.nixfmt.packages.${system}.nixfmt;
                  nodejs = final.nodejs.overrideAttrs (oldAttrs: {
                    doCheck = false;
                  });
                })
              ];
            })
          else
            # (import pkgs {
            (import nixpkgs {
              # config.replaceStdenv = { pkgs }: (pkgs.clangStdenv);

              # stdenv = super.withCFlags [ "-flto" "-funroll-loops" "-O3" "-enable-rice" "-omg-optimize" "-teach-me-unix"] super.stdenv;
              # localSystem = system;

              localSystem = {
                inherit system;
                gcc.arch = "znver3";
                gcc.mtune = "znver3";
              };
              crossSystem = {
                inherit system;
                gcc.arch = "znver3";
                gcc.mtune = "znver3";
              };

              overlays = [
                (import ./plugins.nix inputs)
                lze-flk.overlays.default
                lzextras-flk.overlays.default
                # (prev: final: {
                #   stdenv = final.stdenvAdapters.withCFlags [] final.llvmPackages_latest.stdenv;
                #   # stdenv = final.llvmPackages_latest.stdenv.override(old : {
                #   #
                #   # });
                #
                # })
                #   stdenv = prev.llvmPackages_latest.stdenv.withCFlags
                #   [
                # # credit https://github.com/moni-dz/nixpkgs-f2k/blob/ca75dc2c9d41590ca29555cddfc86cf950432d5e/flake.nix#L237-L289
                #     "-O3"
                #     "-flto=auto"
                #     "-ffat-lto-objects"
                #     "-pipe"
                #     "-ffloat-store"
                #     "-fexcess-precision=fast"
                #     "-ffast-math"
                #     "-fno-rounding-math"
                #     "-fno-signaling-nans"
                #     "-fno-math-errno"
                #     "-funsafe-math-optimizations"
                #     "-fassociative-math"
                #     "-freciprocal-math"
                #     "-ffinite-math-only"
                #     "-fno-signed-zeros"
                #     "-fno-trapping-math"
                #     "-frounding-math"
                #     "-fsingle-precision-constant"
                #     "-fcx-limited-range"
                #     "-fcx-fortran-rules"
                #
                #   ]
                #
                #   prev.llvmPackages_latest.stdenv;
                # (prev: final: {
                #   p11-kit = final.p11-kit.overrideAttrs (oldAttrs: {
                #     doCheck = false;
                #   });
                #   mailutils = final.mailutils.overrideAttrs (oldAttrs: {
                #     doCheck = false;
                #   });
                #   bear = final.bear.overrideAttrs (oldAttrs: {
                #     doCheck = false;
                #   });
                #   starship = final.starship.overrideAttrs (oldAttrs: {
                #     doCheck = false;
                #   });

                # })
                (prev: final: {
                  stdenvnew = prev.stdenvAdapters.addAttrsToDerivation {
                    NIX_CFLAGS_COMPILE = "-flto";
                  } prev.stdenv;

                  nixfmt = inputs.nixfmt.packages.${system}.nixfmt;
                  nil = inputs.nil.packages.${system}.nil;

                  # credit: gerg/mnw
                })
                #     doCheck = false;
              ];
            });
        # plugin, config file
        requiredPluginList =
          with pkgs;
          [
            # lazy loading
            vimPlugins.lze
            vimPlugins.lzextras
            colorful-winsep-nvim
            vimPlugins.markid
            blamer-nvim

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
            vimPlugins.telescope-live-grep-args-nvim
            telescope-ui-select
            vimPlugins.yazi-nvim

            # github
            gitlinker-nvim

            # misc
            vimPlugins.surround-nvim
            vimPlugins.undotree
            colorizer

            vimPlugins.dressing-nvim
            vimPlugins.nui-nvim
            vimPlugins.render-markdown-nvim
            vimPlugins.img-clip-nvim
            # git
            vimPlugins.neogit

            vimPlugins.gitsigns-nvim

            # autopairs
            vimPlugins.nvim-autopairs

            # lsp

            vimPlugins.nvim-nio # async-io
            vimPlugins.rust-vim # for formatting
            vimPlugins.image-nvim
            typst-vim
            vimPlugins.vim-ormolu # haskell
            # vimPlugins.coq_nvim
            vimPlugins.lsp_signature-nvim
            vimPlugins.nvim-cmp
            vimPlugins.cmp-path
            vimPlugins.cmp-buffer
            vimPlugins.cmp-cmdline
            vimPlugins.cmp-nvim-lsp
            vimPlugins.lspkind-nvim
            # lsp-config
            vimPlugins.plenary-nvim
            vimPlugins.popup-nvim

            vimPlugins.conform-nvim

            fidget
            vimPlugins.trouble-nvim
            # copilot-lua
            # copilot-cmp
            node-type-nvim
            floating-input

            symbols-nvim

            # treesitter
            nvim-async
            (nvim-ufo.overrideAttrs (oa: {
              doCheck = false;
            }))
            comment-nvim
            #vimPlugins.nvim-treesitter-context
            #vimPlugins.nvim-treesitter-textobjects
            #nvim-treesitter

            # (builtins.attrValues ((lib.filterAttrs (n: v: !(builtins.elem v ["comment"]))) pkgs.vimPlugins.nvim-treesitter.grammarPlugins))

            ((pkgs.vimPlugins.nvim-treesitter.overrideAttrs (oldAttrs: {
              src = pkgs.nvim-treesitter-src;
            })).withAllGrammars
            )

            # (builtins.trace (lib.filterAttrs (name: val: name != "comment") pkgs.vimPlugins.nvim-treesitter.grammarPlugins)
            vimPlugins.telescope-zoxide
            # )
            vimPlugins.nvim-ts-autotag
            vimPlugins.rainbow-delimiters-nvim
            vim-illuminate
            ts-node-action

            # TODO lazy load these
            vimPlugins.typescript-tools-nvim
            vimPlugins.crates-nvim
            coqtail
            coq-lsp-nvim
            vimPlugins.haskell-tools-nvim
          ]
          # ++ lib.optional (system != "aarch64-darwin") [
          #   rust-owl.packages.${system}.rustowl-nvim
          # ]
          ++ (
            pkgs.vimPlugins.nvim-treesitter.grammarPlugins
            |> (lib.filterAttrs (n: _: !(builtins.elem n [ "comment" ])))
            |> builtins.attrValues
          );

        luaModules = [
          "essentials"
          "aesthetics"
          "telescope"
          "github"
          "misc"
          "treesitter"
          "git"
          "autopairs"
          "lsp"
          #"avante"
        ];
        luaLazyModules = [
          "rustaceanvim"
          "haskell-tools-nvim"
          "ferris"
          "parinfer"
          "ghostty"
        ];

        luaRequire' = module: builtins.toString ./required_lua_modules + "/${module}.lua";
        luaLazyRequire' = module: builtins.toString ./lazy_lua_modules + "/${module}.lua";

        myNeovim' = mnw.lib.wrap pkgs {
          providers = {
            ruby.enable = true;
            python3.enable = true;
            nodeJs.enable = true;
            perl.enable = true;
          };
          extraBinPath = builtins.attrValues {
            inherit (pkgs)
              nixfmt
              ruff
              ripgrep
              git
              terraform-ls
              lua-language-server
              clang-tools
              myRSetup
              nodejs
              fd
              nil
              vscode-langservers-extracted
              stylua
              imagemagick
              shellcheck
              shfmt
              prettierd
              just-lsp
              ty
              ;
          };
          neovim = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.system}.default;
          extraLuaPackages = ps: [ ps.magick ];
          plugins = {
            start = requiredPluginList;
            opt = with pkgs; [
              vimPlugins.rustaceanvim
              ferris-nvim
              parinfer-rust-nvim
              ghostty-nvim
            ];
          };
          luaFiles = map luaRequire' luaModules ++ map luaLazyRequire' luaLazyModules;
        };
      in
      {
        defaultPackage = myNeovim';
        apps.defaultApp = {
          type = "app";
          program = "${myNeovim'}/bin/nvim";
        };
        packages.neovim = myNeovim';
      }
    );
}
