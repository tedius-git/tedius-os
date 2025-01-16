{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    wezterm
    jetbrains-mono
  ];

  home.file = {
    ".wezterm.lua".source = ./../dotfiles/wezterm/.wezterm.lua;
  };
}
