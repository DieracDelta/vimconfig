# What is this?

My personal vim config, assembled with `Nix`.

# Usage

```sh
nix run github:DieracDelta/vimconfig
```

Builds are portable across the supported systems and do not add host-specific CPU compiler flags.

# What's enabled

A bunch of common stuff:

- Treesitter 'n co
- LSP for the languages I use
  - trouble for errors
- Git:
  - Neogit (magit for vim)
  - blamer for seeing who wrote what
  - gitsigns for viewing changed LoC
- Surround-nvim for selecting text areas
- Telescope 'n co
- Autopairs
- Which-key for keys
- Copilot
- Parinfer for lisp
