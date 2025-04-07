{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    # nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-24.11";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.hp = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tedius = import ./home.nix;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}
