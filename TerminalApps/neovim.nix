{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # To install Neovim The great
    neovim

    ripgrep # needed for telescope

    # Languajes and its lsp/formatters

    #lua
    lua-language-server # lua lsp
    stylua # lua formatter

    #python
    pyright # python lsp
    black # python formatter

    # typst
    typst
    tinymist # typst lsp
    typstfmt # typst formatter

    # nix
    nil # nix lsp
    alejandra # nix formatter

    #web dev
    typescript-language-server
    superhtml
    tailwindcss-language-server
  ];

  home.file = {
    "nvim" = {
      source = ./../dotfiles/nvim;
      target = ".config/nvim";
      recursive = true;
    };
  };
}
