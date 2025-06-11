{

  description = "Boellers main flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      pkgs-unstable = (import inputs.nixpkgs-unstable) {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      specialArgs = {
        inherit inputs pkgs-unstable;
      };

      desktop-system = "x86_64-linux";
      desktop-pkgs = (import nixpkgs) {
        system = desktop-system;
        config.allowUnfree = true;
      };

    in {
    nixosConfigurations = {
      nixos-vm = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        system = desktop-system;
        pkgs = desktop-pkgs;
        modules = [ 
          
          ./configuration.nix
          # home-manager.nixosModules.home-manager {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;

          #   home-manager.users.boeller = {
          #     home.stateVersion = "25.05";
          #   };
          # }
          ./modules/home-manager.nix
          ./modules/user-boeller.nix
        ] ++ [ ./hardware-configuration/nixos-vm.nix ];
      };
    };
  };	

}
