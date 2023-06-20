# What is this?

My personal vim config, assembled with `Nix`, and using vim2nix.

# Usage

```
nix run github:DieracDelta/vimconfig
```

# What's enabled

A bunch of common stuff:

- Treesitter 'n co
- LSP for the languages I use
  - trouble for errors
- DAP (only set up with the rust adapter so far)
- Git:
  - Neogit (magit for vim)
  - blamer for seeing who wrote what
  - gitsigns for viewing changed LoC
- Surround-nvim for selecting text areas
- Telescope 'n co
- Leap
- Wilder
- Autopairs
- Guess-indent for indentation
- Which-key for keys
- Copilot, Codeium, and Chatgpt for AI driven development
- Parinfer for lisp
- Cornelus for agda
- ltex + ngram for grammarly-esque support
- random lsps that are useful
