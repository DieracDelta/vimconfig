{
  description = "Neovim config";

  inputs = {
    avante-nvim-src = {
      url = "github:yetone/avante.nvim";
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

    neovim-nightly-linux = {
      url = "github:DieracDelta/neovim-nightly-overlay";
      flake = false;
    };

    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      flake = false;
    };
    ghostty-nvim-src = {
      url = "github:isak102/ghostty.nvim";
      flake = false;
    };

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
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
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

    yazi-nvim-src = {
      url = "github:mikavilpas/yazi.nvim";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      flake-utils,
      nixpkgs,
      neovim-nightly,
      neovim-nightly-linux,
      lze-flk,
      lzextras-flk,
      rust-owl,
      avante-nvim-src,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        avante-overlay = (prev: final: rec {
          avante-nvim-lib = final.rustPlatform.buildRustPackage {
            pname = "avante-nvim-lib";
            version = "master";
            src = avante-nvim-src;

            cargoHash = "sha256-pmnMoNdaIR0i+4kwW3cf01vDQo39QakTCEG9AXA86ck=";

            nativeBuildInputs = [
              final.pkg-config
            ];

            buildInputs = [
              final.openssl
            ];

            buildFeatures = [ "luajit" ];
            useFetchCargoVendor = true;

            checkFlags = [
              # Disabled because they access the network.
              "--skip=test_hf"
              "--skip=test_public_url"
              "--skip=test_roundtrip"
            ];
          };
        avante-nvim = final.vimUtils.buildVimPlugin {
          pname = "avante.nvim";
          version = "master";
          src = avante-nvim-src;

          dependencies = with final.vimPlugins; [
            dressing-nvim
            nui-nvim
            nvim-treesitter
            plenary-nvim
          ];

          postInstall =
            let
              ext = final.stdenv.hostPlatform.extensions.sharedLibrary;
            in
            ''
              echo "ROOT"
              ls -a ${avante-nvim-lib}
              echo "LIB"

              ls -a ${avante-nvim-lib}/lib
              mkdir -p $out/build
              ln -s ${avante-nvim-lib}/lib/libavante_repo_map${ext} $out/build/avante_repo_map${ext}
              ln -s ${avante-nvim-lib}/lib/libavante_templates${ext} $out/build/avante_templates${ext}
              ln -s ${avante-nvim-lib}/lib/libavante_tokenizers${ext} $out/build/avante_tokenizers${ext}
              ln -s ${avante-nvim-lib}/lib/libavante_html2md${ext} $out/build/avante_html2md${ext}
              ln -s ${avante-nvim-lib}/lib/libhtml2md${ext} $out/build/html2md${ext}
            '';

          passthru = {
            updateScript = final.nix-update-script {
              attrPath = "vimPlugins.avante-nvim.avante-nvim-lib";
            };

            # needed for the update script
            avante-nvim-lib = final.avante-nvim-lib;
          };

          nvimSkipModule = [
            # Requires setup with corresponding provider
            "avante.providers.azure"
            "avante.providers.copilot"
          ];
          };

        });
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
                avante-overlay
                (import ./plugins.nix inputs)
                lze-flk.overlays.default
                lzextras-flk.overlays.default
                (prev: final: {
                  # credit: gerg/mnw
                  neovim = import "${neovim-nightly-linux}/flake/packages/neovim.nix" {
                    inherit (final) lib pkgs;
                    neovim-src =
                      let
                        lock = final.lib.importJSON "${neovim-nightly}/flake.lock";
                        nodeName = lock.nodes.root.inputs.neovim-src;
                        input = lock.nodes.${nodeName}.locked;
                      in
                      builtins.trace input
                      pkgs.fetchFromGitHub {
                        inherit (input) owner repo rev;
                        hash = input.narHash;
                      };
                  };
                })
              ];
            })
          else
            let
              pkgs' = import nixpkgs { inherit system; };
              pkgs'' = pkgs'.applyPatches {
                src = nixpkgs;
                name = "144748.patch";
                patches = [ ./144748.patch ];
              };
            in
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
                avante-overlay
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
                  # credit: gerg/mnw
                  neovim = import "${neovim-nightly-linux}/flake/packages/neovim.nix" {
                    inherit (final) lib pkgs;
                    neovim-src =
                      let
                        lock = final.lib.importJSON "${neovim-nightly}/flake.lock";
                        nodeName = lock.nodes.root.inputs.neovim-src;
                        input = lock.nodes.${nodeName}.locked;
                      in
                      builtins.trace input
                      pkgs.fetchFromGitHub {
                        inherit (input) owner repo rev;
                        hash = input.narHash;
                      };
                  };
                })
              ];
            });
        # plugin, config file
        lazyPluginList = with pkgs; [
          [rustaceanvim "rustaceanvim"]
          [vimPlugins.haskell-tools-nvim "haskell-tools-nvim"]
          [ferris-nvim "ferris"]
          [parinfer-rust-nvim "parinfer"]
          [ghostty-nvim "ghostty"]
          # [vim-ormolu "vim-ormolu"]

        ];
        requiredPluginList = with pkgs; [
          # lazy loading
          vimPlugins.lze
          vimPlugins.lzextras


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
          colorizer

          vimPlugins.dressing-nvim
          vimPlugins.nui-nvim
          vimPlugins.render-markdown-nvim
          vimPlugins.img-clip-nvim
          # avante-nvim
          # # prolly redunandt
          # avante-nvim-lib

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
          typst-vim
          vimPlugins.vim-ormolu # haskell
          vimPlugins.coq_nvim
          vimPlugins.lsp_signature-nvim
          vimPlugins.lspkind-nvim
          lsp-config
          plenary-nvim
          vimPlugins.popup-nvim

          fidget
          vimPlugins.trouble-nvim
          copilot-lua
          # copilot-cmp
          node-type-nvim
          floating-input

          symbols-nvim

          # treesitter
          nvim-async
          nvim-ufo
          comment-nvim
          vimPlugins.nvim-treesitter-context
          vimPlugins.nvim-treesitter-textobjects
          vimPlugins.nvim-treesitter
          # (builtins.attrValues ((lib.filterAttrs (n: v: !(builtins.elem v ["comment"]))) pkgs.vimPlugins.nvim-treesitter.grammarPlugins))

          # ((pkgs.vimPlugins.nvim-treesitter.overrideAttrs (oldAttrs: {
          #   src = pkgs.nvim-treesitter-src;
          # })).withAllGrammars)

          # (builtins.trace (lib.filterAttrs (name: val: name != "comment") pkgs.vimPlugins.nvim-treesitter.grammarPlugins)
          vimPlugins.telescope-zoxide
          # )
          vimPlugins.nvim-ts-autotag
          vimPlugins.rainbow-delimiters-nvim
          vim-illuminate
          markid
          ts-node-action

          # TODO lazy load these
          vimPlugins.typescript-tools-nvim
          vimPlugins.crates-nvim
          coqtail
          coq-lsp-nvim
          rust-owl.packages.${system}.rustowl-nvim

        ] ++
          (pkgs.vimPlugins.nvim-treesitter.grammarPlugins
          |> (lib.filterAttrs (n: _: !(builtins.elem n [ "comment" ])))
          |> builtins.attrValues);
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
          # "avante"
        ];
        luaRequire = module: builtins.readFile (builtins.toString ./required_lua_modules + "/${module}.lua");
        luaLazyRequire = x: builtins.readFile (builtins.toString ./lazy_lua_modules + "/${builtins.elemAt x 1}.lua");
        requiredPluginAttrSet = map (x: { plugin = x; }) requiredPluginList;
        lazyPluginAttrSet = map (l :
          {
            plugin = builtins.elemAt l 0;
            optional = true;
          }
        ) lazyPluginList;
        orig_config = pkgs.neovimUtils.makeNeovimConfig {
          withNodeJs = true;
          withRuby = true;
          withPython3 = true;
          plugins = requiredPluginAttrSet ++ lazyPluginAttrSet;
        };
        config = orig_config // {
          luaRcContent = builtins.concatStringsSep "\n" ((map luaRequire luaModules) ++ (map luaLazyRequire lazyPluginList));
          wrapperArgs = [
            "--suffix"
            "PATH"
            ":"
            "${pkgs.lib.makeBinPath # great place for pipe operator
              (
                with pkgs;
                [
                  ripgrep
                  git
                  terraform-ls
                  lua-language-server
                  clang-tools
                  myRSetup
                  nodejs
                  nodePackages.vscode-json-languageserver
                  ripgrep
                  fd
                  nil

                  rust-owl.packages.${system}.rustowl

                ]
              )
            }"
          ];
        };
        myNeovim = pkgs.wrapNeovimUnstable (pkgs.neovim.overrideAttrs (oldAttrs: {
          buildInputs = oldAttrs.buildInputs ++ (with pkgs; [ tree-sitter ]);
        })) config;
      in
      {
        defaultPackage = myNeovim;
        apps.defaultApp = {
          type = "app";
          program = "${myNeovim}/bin/nvim";
        };
        packages.neovim = myNeovim;
      }
    );
}
