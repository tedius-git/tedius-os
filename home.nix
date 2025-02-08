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
    ./DesktopApps/zathura.nix # Pdf reader
    ./TerminalApps/neovim.nix
    ./TerminalApps/yazi.nix
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    gh # Github cli
    lazygit
    whatsapp-for-linux
    obsidian # Notes
    geogebra6 # Matematical graphics
    obs-studio
    ghostty
    inkscape
    chromium
    discord-canary
    dwarf-fortress-packages.dwarf-fortress-full # Game
    inputs.zen-browser.packages."${pkgs.system}".default
  ];

  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
