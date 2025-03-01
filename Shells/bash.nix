{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../TerminalApps/starship.nix
    ./../TerminalApps/neovim.nix
    ./../TerminalApps/yazi.nix
    ./../TerminalApps/bash_fun.nix
  ];

  home.packages = with pkgs; [
    fzf
    zoxide
    eza
    fastfetch
    bat
    blesh
    chafa
  ];

  home.file = {
    ".bashrc".source = ./../dotfiles/bash/.bashrc;
    ".bash_profile".source = ./../dotfiles/bash/.bash_profile;
    ".blerc".source = ./../dotfiles/bash/.blerc;
  };
}
