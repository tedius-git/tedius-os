{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    gnome-extension-manager
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash2dock-lite

    kmonad
  ];
}
