{
  description = "A very basic flake";

  inputs = {
    nixpkg.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgsold.url = "github:nixos/nixpkgs?ref=nixos-21.11";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.hp = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};

      modules = [
        ./configuration.nix
      ];
    };
  };
}
