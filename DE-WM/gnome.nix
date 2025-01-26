{
  config,
  pkgs,
  inputs,
  ...
}: {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      accent-color = "purple";
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/tedius/tedius-os/Assets/beach.jpg";
      picture-uri-dark = "file:///home/tedius/tedius-os/Assets/puffy-stars.jpg";
    };
  };

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
    gnomeExtensions.open-bar
    gnome-tweaks
  ];
}
