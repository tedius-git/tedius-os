{
  config,
  pkgs,
  inputs,
  ...
}: {

  gtk = {
    enable = true;

    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };

    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.mint-cursor-themes;
    };
  };

  home.packages = with pkgs; [
    gnome-extension-manager
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash2dock-lite
    gnomeExtensions.panel-workspace-scroll
    gnome-tweaks
  ];
}
