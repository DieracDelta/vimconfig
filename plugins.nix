inputs: final: prev:
let
  withSrc =
    pkg: src:
    pkg.overrideAttrs (_: {
      inherit src;
    });
  plugin =
    pname: src:
    prev.vimUtils.buildVimPlugin {
      inherit pname src;
      version = "master";
    };
  pluginNoChecks =
    pname: src:
    prev.vimUtils.buildVimPlugin {
      inherit pname src;
      version = "master";
      doCheck = false;
      #nvimSkipModules = ["spec_init"];
    };
in
with inputs;
{
  terraform-ls =
    with prev;
    (buildGoModule rec {
      pname = "terraform-ls";
      version = "0.27.0";

      src = fetchFromGitHub {
        owner = "hashicorp";
        repo = pname;
        rev = "v${version}";
        sha256 = "sha256-TWxYCHdzeJtdyPajA3XxqwpDufXnLod6LWa28OHjyms=";
      };

      vendorHash = "sha256-e/m/8h0gF+kux+pCUqZ7Pw0XlyJ5dL0Zyqb0nUlgfpc=";
      ldflags = [
        "-s"
        "-w"
        "-X main.version=v${version}"
        "-X main.prerelease="
      ];

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
        changelog = "https://github.com/hashicorp/terraform-ls/blob/v${version}/CHANGELOG.md";
        license = licenses.mpl20;
        maintainers = with maintainers; [
          mbaillie
          jk
        ];
      };
    });

  nil = inputs.nil.packages.${prev.system}.nil;

  # Packaging plugins with Nix
  blamer-nvim = plugin "blamer-nvim" blamer-nvim-src;
  colorizer = plugin "colorizer" colorizer-src;
  comment-nvim = plugin "comment-nvim" comment-nvim-src;
  dracula = plugin "dracula" dracula-nvim;
  gruvbox-nvim = plugin "gruvbox-nvim" gruvbox-nvim-src;
  fidget = plugin "fidget" fidget-src;
  parinfer-rust-nvim = plugin "parinfer-rust" prev.parinfer-rust;
  telescope-ui-select = plugin "telescope-ui-select" telescope-ui-select-src;
  which-key = plugin "which-key" which-key-src;
  vim-illuminate = plugin "vim-illuminate" vim-illuminate-src;
  nvim-ufo = plugin "nvim-ufo" nvim-ufo-src;
  nvim-async = plugin "nvim-async" nvim-async-src;

  myRSetup = (
    prev.rWrapper.override {
      packages = with prev.rPackages; [
        # vscDebugger
        ggplot2
        dplyr
        xts
        languageserver
      ];
    }
  );

  nvim-dap = plugin "nvim-dap" nvim-dap-src;

  nvim-dap-virtual-text = plugin "nvim-dap-virtual-text" nvim-dap-virtual-text-src;

  nvim-dap-ui = plugin "nvim-dap-ui" nvim-dap-ui-src;

  telescope-dap-nvim = plugin "telescope-dap-nvim" telescope-dap-nvim-src;

  node-type-nvim = plugin "node-type-nvim" node-type-nvim-src;

  floating-input = plugin "floating-input" floating-input-src;

  ts-node-action = plugin "ts-node-action" ts-node-action-src;

  telescope-dapzzzz = plugin "telescope-dapzzzz" telescope-dapzzzz-src;

  nvim-treesitter = plugin "nvim-treesitter" nvim-treesitter-src;

  typst-vim = plugin "typst-vim" typst-vim-src;

  vim-circom-syntax = plugin "vim-circom-syntax" vim-circom-syntax-src;

  ferris-nvim = plugin "ferris-nvim" ferris-nvim-src;

  gitlinker-nvim = (plugin "gitlinker-nvim" gitlinker-nvim-src).overrideAttrs (oldAttrs: {
    nvimSkipModules = [ "spec_init" ]; # I think this is just used for tests
  });

  coq-lsp-nvim = plugin "coq-lsp-nvim" coq-lsp-nvim-src;

  coqtail = plugin "coqtail" coqtail-src;

  ghostty-nvim = plugin "ghostty-nvim" ghostty-nvim-src;

  symbols-nvim = plugin "symbols-nvim" symbols-nvim-src;

  colorful-winsep-nvim = plugin "colorful-winsep-nvim" colorful-winsep-nvim-src;

  telescope-live-grep-args = plugin "telescope-live-grep-args" telescope-live-grep-args-src;

  claudecode-nvim = plugin "claudecode-nvim" claudecode-nvim-src;

}

