{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    starship
    blesh
  ];

  home.file = {
    starship = {
      source = ./../dotfiles/starship/starship.toml;
      target = ".config/starship.toml";
    };
  };
}
