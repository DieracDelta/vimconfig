{
  description = "Tutorial Flake accompanying vimconf talk.";

  # Input source for our derivation
  inputs = {
    master.url = "github:NixOS/nixpkgs/master";
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    stable.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    terraform-ls-src = {
      url = "github:hashicorp/terraform-ls";
      flake = false;
    };
    nix2vim = {
      url = "github:gytis-ivaskevicius/nix2vim";
      inputs.nixpkgs.follows = "stable";
    };
    neovim = { url = "github:neovim/neovim?dir=contrib&tag=master"; };
    telescope-src = {
      url = "github:nvim-telescope/telescope.nvim";
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
    rnix-lsp = {
      url = "github:nix-community/rnix-lsp";
      inputs.nixpkgs.follows = "stable";
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
      url =
        "github:folke/which-key.nvim?ref=bd4411a2ed4dd8bb69c125e339d837028a6eea71";
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
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, neovim, dracula-nvim, nix2vim
    , comment-nvim-src, blamer-nvim-src, telescope-ui-select-src, rust-tools-src
    , which-key-src, fidget-src, neogen-src, conceal-src, colorizer-src, stable
    , master, rnix-lsp, ... }:
    let
      # Function to override the source of a package
      withSrc = pkg: src: pkg.overrideAttrs (_: { inherit src; });

      overlay = prev: final: rec {
        rnix-lsp = inputs.rnix-lsp.packages.${prev.system}.rnix-lsp;
        terraform-ls = with prev;
          (buildGoModule rec {
            pname = "terraform-ls";
            version = "0.27.0";

            src = fetchFromGitHub {
              owner = "hashicorp";
              repo = pname;
              rev = "v${version}";
              sha256 = "sha256-TWxYCHdzeJtdyPajA3XxqwpDufXnLod6LWa28OHjyms=";
            };

            vendorSha256 =
              "sha256-e/m/8h0gF+kux+pCUqZ7Pw0XlyJ5dL0Zyqb0nUlgfpc=";
            ldflags =
              [ "-s" "-w" "-X main.version=v${version}" "-X main.prerelease=" ];

            # There's a mixture of tests that use networking and several that fail on aarch64
            doCheck = false;

            doInstallCheck = true;
            installCheckPhase = ''
              runHook preInstallCheck
              $out/bin/terraform-ls --help
              $out/bin/terraform-ls version | grep "v${version}"
              runHook postInstallCheck
            '';

            meta = with lib; {
              description = "Terraform Language Server (official)";
              homepage = "https://github.com/hashicorp/terraform-ls";
              changelog =
                "https://github.com/hashicorp/terraform-ls/blob/v${version}/CHANGELOG.md";
              license = licenses.mpl20;
              maintainers = with maintainers; [ mbaillie jk ];
            };
          });

        telescope-nvim =
          (withSrc prev.vimPlugins.telescope-nvim inputs.telescope-src);
        cmp-buffer = (withSrc prev.vimPlugins.cmp-buffer inputs.cmp-buffer);
        nvim-cmp = (withSrc prev.vimPlugins.nvim-cmp inputs.nvim-cmp);

        cmp-nvim-lsp = withSrc prev.vimPlugins.cmp-nvim-lsp inputs.cmp-nvim-lsp;

        # Example of packaging plugin with Nix
        dracula = prev.vimUtils.buildVimPluginFrom2Nix {
          pname = "dracula-nvim";
          version = "master";
          src = dracula-nvim;
        };

        comment-nvim = prev.vimUtils.buildVimPluginFrom2Nix {
          pname = "comment-nvim";
          version = "master";
          src = comment-nvim-src;
        };

        blamer-nvim = prev.vimUtils.buildVimPluginFrom2Nix {
          pname = "blamer-nvim";
          version = "master";
          src = blamer-nvim-src;
        };

        parinfer-rust-nvim = prev.vimUtils.buildVimPluginFrom2Nix {
          pname = "parinfer-rust";
          version = "master";
          src = prev.pkgs.parinfer-rust;
        };

        telescope-ui-select = prev.vimUtils.buildVimPluginFrom2Nix {
          pname = "telescope-ui-select";
          version = "master";
          src = telescope-ui-select-src;
        };

        rust-tools = prev.vimUtils.buildVimPluginFrom2Nix {
          pname = "rust-tools";
          version = "master";
          src = rust-tools-src;
        };

        fidget = prev.vimUtils.buildVimPluginFrom2Nix {
          pname = "fidget";
          version = "master";
          src = fidget-src;
        };

        neogen = prev.vimUtils.buildVimPluginFrom2Nix {
          pname = "neogen";
          version = "master";
          src = neogen-src;
        };

        which-key = prev.vimUtils.buildVimPluginFrom2Nix {
          pname = "which-key";
          version = "master";
          src = which-key-src;
        };

        conceal = prev.vimUtils.buildVimPluginFrom2Nix {
          pname = "conceal";
          version = "master";
          src = conceal-src;
        };

        colorizer = prev.vimUtils.buildVimPluginFrom2Nix {
          pname = "colorizer";
          version = "master";
          src = colorizer-src;
        };
      };

    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ neovim.overlay overlay nix2vim.overlay ];
        };
        neovimConfig = pkgs.neovimBuilder {
          # Build with NodeJS
          withNodeJs = true;
          package = pkgs.neovim;
          imports = [
            ./modules/essentials.nix
            ./modules/lsp.nix
            ./modules/aesthetics.nix
            ./modules/telescope.nix
            ./modules/misc.nix
            ./modules/treesitter.nix
            ./modules/git.nix
          ];
        };
      in {
        # The package built by `nix build .`
        defaultPackage = neovimConfig;
        # The app run by `nix run .`
        defaultApp = {
          type = "app";
          program = "${neovimConfig}/bin/nvim";
        };

      });
}
