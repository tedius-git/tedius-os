{
  config,
  pkgs,
  inputs,
  ...
}: {
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy";
    };
    "org/gnome/shell/extensions/pop-shell" = {
      hint-color-rgba = "rgba(203, 166, 247,1)";
    };
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };
  };

  home.packages = with pkgs; [
    gnome-extension-manager
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash2dock-lite
    gnomeExtensions.panel-workspace-scroll
    gnomeExtensions.open-bar
    gnomeExtensions.pop-shell
    gnomeExtensions.just-perfection
    gnome-tweaks
  ];
}
