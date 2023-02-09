inputs: final: prev:
let
  withSrc = pkg: src: pkg.overrideAttrs (_: { inherit src; });
  plugin = pname: src: prev.vimUtils.buildVimPluginFrom2Nix {
    inherit pname src;
    version = "master";
  };
in
with inputs; {

  codium-lsp = with prev;
    stdenv.mkDerivation rec {
      pname = "codium-lsp";
      version = "v1.1.33";

      src = fetchurl {
        url = "https://github.com/Exafunction/codeium/releases/download/language-server-v1.1.33/language_server_macos_arm.gz";
        sha256 = "sha256-NYf0hSNO6bmICBFjpnzOvuKRBqPG7ijhdfbO02iOTBI=";
      };

      nativeBuildInputs = [
        # autoPatchelfHook
      ];

      buildInputs = [
      ];

      phases = [ "installPhase" ];

      # sourceRoot = ".";

      installPhase = ''
        mkdir -p $out/bin
        gzip -d $src -c > $out/bin/language_server
        chmod +x $out/bin/language_server
      '';

    }
  ;

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

      vendorSha256 = "sha256-e/m/8h0gF+kux+pCUqZ7Pw0XlyJ5dL0Zyqb0nUlgfpc=";
      ldflags = [ "-s" "-w" "-X main.version=v${version}" "-X main.prerelease=" ];

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
        maintainers = with maintainers; [ mbaillie jk ];
      };
    });

  nil = inputs.nil.packages.${prev.system}.nil;

  cornelis-vim = inputs.cornelis.packages.${prev.system}.cornelis-vim;

  telescope-nvim = (withSrc prev.vimPlugins.telescope-nvim inputs.telescope-src);
  cmp-buffer = (withSrc prev.vimPlugins.cmp-buffer inputs.cmp-buffer);
  nvim-cmp = (withSrc prev.vimPlugins.nvim-cmp inputs.nvim-cmp);

  cmp-nvim-lsp = withSrc prev.vimPlugins.cmp-nvim-lsp inputs.cmp-nvim-lsp;

  # Packaging plugins with Nix
  blamer-nvim = plugin "blamer-nvim" blamer-nvim-src;
  colorizer = plugin "colorizer" colorizer-src;
  comment-nvim = plugin "comment-nvim" comment-nvim-src;
  conceal = plugin "conceal" conceal-src;
  dracula = plugin "dracula" dracula-nvim;
  fidget = plugin "fidget" fidget-src;
  neogen = plugin "neogen" neogen-src;
  parinfer-rust-nvim = plugin "parinfer-rust" prev.parinfer-rust;
  rust-tools = plugin "rust-tools" rust-tools-src;
  telescope-ui-select = plugin "telescope-ui-select" telescope-ui-select-src;
  which-key = plugin "which-key" which-key-src;
  guess-indent = plugin "guess-indent" guess-indent-src;
  leap = plugin "leap" leap-src;
  wilder-nvim = plugin "wilder-nvim" wilder-nvim-src;
  plenary-nvim = plugin "plenary-nvim" plenary-nvim-src;
  nvim-autopairs = plugin "nvim-autopairs" nvim-autopairs-src;
  vim-illuminate = plugin "vim-illuminate" vim-illuminate-src;
  nvim-ufo = plugin "nvim-ufo" nvim-ufo-src;
  nvim-async = plugin "nvim-async" nvim-async-src;
  conjure = plugin "conjure" conjure-src;
  lsp-config = plugin "lsp-config" lsp-config-src;
  # lsp_lines = plugin "lsp_lines" lsp_lines-src;
  markid = plugin "markid" markid-src;

  copilot-lua = plugin "copilot-lua" copilot-lua-src;
  copilot-cmp = plugin "copilot-cmp" copilot-cmp-src;
  copilot-vim = plugin "copilot-vim" copilot-vim-src;

  codium-nvim = plugin "codium-nvim" codium-nvim-src;

  neural = plugin "neural" neural-src;

  nui-nvim = plugin "nui-nvim" nui-nvim-src;

  significant-nvim = plugin "significant-nvim" significant-nvim-src;

  chatgpt-nvim = plugin "chatgpt-nvim" chatgpt-nvim-src;

  myRSetup = ( prev.rWrapper.override{ packages = with prev.rPackages; [ ggplot2 dplyr xts languageserver ]; });

}
