{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hyprland

    kitty
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
