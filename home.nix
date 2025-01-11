{
  config,
  pkgs,
  inputs,
  ...
}: {
  # TODO please change the username & home directory to your own
  home.username = "tedius";
  home.homeDirectory = "/home/tedius";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    wezterm
    cascadia-code
    zoxide
    neovim
    gh
    gcc
    starship
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dock-from-dash
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

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
