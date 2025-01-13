{
  config,
  pkgs,
  inputs,
  ...
}: {
  # TODO please change the username & home directory to your own
  home.username = "tedius";
  home.homeDirectory = "/home/tedius";


  imports = [
    ./gnome.nix
    ./starship.nix
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    fzf
    wezterm
    cascadia-code
    zoxide
    neovim
    gh
    gcc
    lazygit
    ripgrep
    whatsapp-for-linux
    lua-language-server
    pyright
    tinymist
    nil
    stylua
    black
    typst
    typstfmt
    alejandra
    eza
    python3
    julia
    gleam
    bat
    chafa
    fastfetch
    zathura
    inputs.zen-browser.packages."${pkgs.system}".specific
  ];

  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
