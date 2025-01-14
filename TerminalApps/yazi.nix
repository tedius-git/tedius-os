{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    yazi
  ];

  home.file = {
    ".config/yazi/yazi.toml".source = ./../dotfiles/yazi/yazi.toml;
    ".config/yazi/keymap.toml".source = ./../dotfiles/yazi/keymap.toml;
    ".config/yazi/theme.toml".source = ./../dotfiles/yazi/catppuccin-mocha-mauve.toml;
  };
}
