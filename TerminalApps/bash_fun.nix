{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    btop
    cmatrix
    bastet
  ];

  home.file = {
    ".config/btop/themes/catppuccin-mocha.theme".source = ./../dotfiles/btop/catppuccin_mocha.theme;
  };
}
