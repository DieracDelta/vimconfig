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

    claudecode-nvim-src = {
      url = "github:coder/claudecode.nvim";
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

    typst-vim-src = {
      url = "github:kaarmu/typst.vim";
      flake = false;
    };
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/master";

    vim-circom-syntax-src = {
      url = "github:iden3/vim-circom-syntax";
      flake = false;
    };

    vim-illuminate-src = {
      url = "github:RRethy/vim-illuminate";
      flake = false;
    };

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    telescope-live-grep-args-src = {
      url = "github:nvim-telescope/telescope-live-grep-args.nvim";
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
    which-key-src = {
      url = "github:folke/which-key.nvim?ref=bd4411a2ed4dd8bb69c125e339d837028a6eea71";
      flake = false;
    };
    colorizer-src = {
      url = "github:powerman/vim-plugin-AnsiEsc";
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

    coq-lsp-nvim-src = {
      url = "github:DieracDelta/coq-lsp.nvim";
      flake = false;
    };

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

    nvim-treesitter-src = {
      url = "github:nvim-treesitter/nvim-treesitter";
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
      nixpkgs,
      neovim-nightly-overlay,
      lze-flk,
      lzextras-flk,
      rust-owl,
      mnw,
      ...
    }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems f;

      mkNeovim = { system, isMinimal ? false }:
      let

        # Common overlays used by all systems
        commonOverlays = [
          (import ./plugins.nix inputs)
          lze-flk.overlays.default
          lzextras-flk.overlays.default
        ];

        pkgs =
          if system == "x86_64-linux" then
            # Full config with znver3 useflags
            (import nixpkgs {
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
              overlays = commonOverlays ++ [
                (prev: final: {
                  stdenvnew = prev.stdenvAdapters.addAttrsToDerivation {
                    NIX_CFLAGS_COMPILE = "-flto";
                  } prev.stdenv;
                  nixfmt = inputs.nixfmt.packages.${system}.nixfmt;
                  nil = inputs.nil.packages.${system}.nil;
                })
              ];
            })
          else if system == "aarch64-linux" then
            # Minimal config for ARM Linux - no arch tuning, space-optimized
            (import nixpkgs {
              inherit system;
              overlays = commonOverlays ++ [
                (prev: final: {
                  nil = inputs.nil.packages.${system}.nil;
                  nixfmt = inputs.nixfmt.packages.${system}.nixfmt;
                })
              ];
            })
          else
            # aarch64-darwin: Full config, no useflags
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
              overlays = commonOverlays ++ [
                (prev: final: {
                  nil = inputs.nil.packages.${system}.nil;
                  nixfmt = inputs.nixfmt.packages.${system}.nixfmt;
                  nodejs = final.nodejs.overrideAttrs (oldAttrs: {
                    doCheck = false;
                  });
                })
              ];
            });

        # Build-time theme variant based on target system
        # darwin = green forest theme, arm = red crimson theme, default = original gruvbox
        themeVariant =
          if nixpkgs.lib.hasInfix "darwin" system then "darwin"
          else if system == "aarch64-linux" then "arm"
          else "default";

        # Write theme config to a Lua file that sets a global variable for aesthetics.lua
        themeConfigFile = pkgs.writeText "gruvbox-theme-variant.lua" ''
          -- Set by Nix at build time based on target system
          vim.g.gruvbox_theme_variant = "${themeVariant}"
        '';

        # plugin, config file
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

          # misc
          vimPlugins.nui-nvim

          # lsp
          vimPlugins.nvim-nio
          vimPlugins.rust-vim
          typst-vim
          vimPlugins.lsp_signature-nvim
          vimPlugins.nvim-cmp
          vimPlugins.cmp-path
          vimPlugins.cmp-buffer
          vimPlugins.cmp-cmdline
          vimPlugins.cmp-nvim-lsp
          vimPlugins.lspkind-nvim
          vimPlugins.plenary-nvim
          vimPlugins.popup-nvim

          # treesitter
          nvim-async
        ] ++ pkgs.lib.optionals (!isMinimal) [
          # Full builds only - excluded from aarch64-linux minimal
          vimPlugins.image-nvim    # requires imagemagick
          vimPlugins.vim-ormolu    # haskell formatter
        ];

        luaModules = [
          "essentials"
          "aesthetics"
          "lsp"
          "completion"
        ];
        luaLazyModules = [
          "rustaceanvim"
          "ferris"
          "parinfer"
          "ghostty"
          "lsp_servers"
          "typescript"
          "crates"
          "telescope"
          "gitlinker"
          "git"
          "gitsigns"
          "treesitter"
          "autopairs"
          "misc"
          "ui"
          "formatting"
        ] ++ pkgs.lib.optionals (!isMinimal) [
          # Full builds only - excluded from aarch64-linux minimal
          "haskell-tools-nvim"
          "lean"
          "claudecode"
          "coq"
        ];

        luaRequire' = module: builtins.toString ./required_lua_modules + "/${module}.lua";
        luaLazyRequire' = module: builtins.toString ./lazy_lua_modules + "/${module}.lua";

        myNeovim' = mnw.lib.wrap pkgs {
          providers = {
            ruby.enable = !isMinimal;
            python3.enable = !isMinimal;
            nodeJs.enable = !isMinimal;
            perl.enable = !isMinimal;
          };
          extraBinPath =
            builtins.attrValues {
              inherit (pkgs)
                nixfmt
                ruff
                ripgrep
                fd
                nil
                vscode-langservers-extracted
                stylua
                shellcheck
                shfmt
                prettierd
                just-lsp
                ty
                ;
            }
            ++ [ (if isMinimal then pkgs.gitMinimal else pkgs.git) ]
            ++ pkgs.lib.optionals (!isMinimal) [
              # Full builds only - excluded from aarch64-linux minimal
              pkgs.clang-tools
              pkgs.terraform-ls
              pkgs.lua-language-server
              pkgs.myRSetup
              pkgs.imagemagick
            ]
            ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
              pkgs.inotify-tools
            ]
            ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
              pkgs.sourcekit-lsp
              pkgs.swift-format
              pkgs.swiftlint
            ];
          neovim = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.system}.default;
          extraLuaPackages = ps: pkgs.lib.optionals (!isMinimal) [ ps.magick ];
          plugins = {
            start = requiredPluginList;
            opt = with pkgs; [
              vimPlugins.rustaceanvim
              ferris-nvim
              parinfer-rust-nvim
              ghostty-nvim
              vimPlugins.typescript-tools-nvim
              vimPlugins.crates-nvim
              # telescope-nvim is pulled in as dependency of its extensions
              vimPlugins.telescope-file-browser-nvim
              vimPlugins.telescope-live-grep-args-nvim
              telescope-ui-select
              vimPlugins.telescope-zoxide
              vimPlugins.yazi-nvim
              gitlinker-nvim
              vimPlugins.neogit
              vimPlugins.gitsigns-nvim
              blamer-nvim
              (nvim-ufo.overrideAttrs (oa: {
                doCheck = false;
              }))
              comment-nvim
              vimPlugins.nvim-ts-autotag
              vimPlugins.rainbow-delimiters-nvim
              vim-illuminate
              vimPlugins.surround-nvim
              vimPlugins.undotree
              colorizer
              vimPlugins.nvim-autopairs
              vimPlugins.markid
              ts-node-action
              colorful-winsep-nvim
              fidget
              vimPlugins.trouble-nvim
              symbols-nvim
              node-type-nvim
              floating-input
              vimPlugins.dressing-nvim
              vimPlugins.conform-nvim
            ] ++ pkgs.lib.optionals (!isMinimal) [
              # Full builds only - excluded from aarch64-linux minimal
              vimPlugins.lean-nvim
              vimPlugins.snacks-nvim
              claudecode-nvim
              coq-lsp-nvim
              coqtail
              vimPlugins.haskell-tools-nvim
            ];
          };
          luaFiles = [ themeConfigFile ] ++ map luaRequire' luaModules ++ map luaLazyRequire' luaLazyModules;
        };
      in
      myNeovim';

    in
    {
      defaultPackage = forAllSystems (system: mkNeovim { inherit system; isMinimal = false; });
      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${mkNeovim { inherit system; isMinimal = false; }}/bin/nvim";
        };
        minimal = {
          type = "app";
          program = "${mkNeovim { inherit system; isMinimal = true; }}/bin/nvim";
        };
      });
      packages = forAllSystems (system: {
        default = mkNeovim { inherit system; isMinimal = false; };
        neovim = mkNeovim { inherit system; isMinimal = false; };
        neovim-minimal = mkNeovim { inherit system; isMinimal = true; };
      });
      hydraJobs.x86_64-linux = {
        neovim = self.packages.x86_64-linux.neovim;
        neovim-minimal = self.packages.x86_64-linux.neovim-minimal;
      };
    };
}
