{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    wezterm
    cascadia-code
  ];

  home.file = {
    ".wezterm.lua".source = ./../dotfiles/wezterm/.wezterm.lua;
  };
}
