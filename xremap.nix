{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.xremap-flake.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    inputs.xremap-flake.packages.${system}.default
  ];
}
