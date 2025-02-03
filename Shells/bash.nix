{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../TerminalApps/starship.nix
  ];

  home.packages = with pkgs; [
    fzf
    zoxide
    eza
    fastfetch
    bat
    blesh
  ];

  home.file = {
    ".bashrc".source = ./../dotfiles/bash/.bashrc;
    ".bash_profile".source = ./../dotfiles/bash/.bash_profile;
  };
}
