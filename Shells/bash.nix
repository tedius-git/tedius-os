{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./starship.nix
  ];

  home.packages = with pkgs; [
    fzf
    zoxide
    eza
    fastfetch
    bat
  ];

  home.file = {
    ".bashrc".source = ./dotfiles/bash/.bashrc;
    ".bash_profile".source = ./dotfiles/bash/.bash_profile;
  };
}
