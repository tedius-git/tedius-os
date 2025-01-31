{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    zathura
  ];

  home.file = {
    ".wezterm.lua".source = ./../dotfiles/wezterm/.wezterm.lua;
    ".config/zathura/catppuccin-latte".source = ./../dotfiles/zathura/catppuccin-latte;
    ".config/zathura/catppuccin-mocha".source = ./../dotfiles/zathura/catppuccin-mocha;
    ".config/zathura/zathurarc".source = ./../dotfiles/zathura/zathurarc;
  };
}
