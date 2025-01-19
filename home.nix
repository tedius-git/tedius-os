{
  config,
  pkgs,
  inputs,
  ...
}: {
  # TODO please change the username & home directory to your own
  home.username = "tedius";
  home.homeDirectory = "/home/tedius";

  imports = [
    ./DE-WM/gnome.nix
    ./Shells/bash.nix
    ./DesktopApps/wezterm.nix
    ./TerminalApps/neovim.nix
    ./TerminalApps/yazi.nix
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    gh # Github cli
    lazygit
    whatsapp-for-linux
    zathura # Pdf reader
    obsidian # Notes
    geogebra6 # Matematical graphics
    obs-studio 
    ghostty
    inkscape
    inputs.zen-browser.packages."${pkgs.system}".default
  ];

  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
