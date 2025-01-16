{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    wezterm
    cascadia-code
    jetbrains-mono
  ];

  home.file = {
    ".wezterm.lua".source = ./../dotfiles/wezterm/.wezterm.lua;
  };
}
