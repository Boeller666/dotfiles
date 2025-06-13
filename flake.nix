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
      nixos-vm = let
        username = "boeller";
        specialArgs = {inherit inputs username;};
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = desktop-system;
          pkgs = desktop-pkgs;
          modules = [
            ./configuration.nix
            # ./modules/audio.nix
            # ./modules/browser.nix
            ./modules/home-manager.nix
            # ./modules/password-manager.nix
            ./modules/user-self.nix
          ] ++ [ ./hardware-configuration/nixos-vm.nix ];
        };

      ReneGaLX-NB = let
        username = "renega";
        specialArgs = {inherit inputs username;};
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = desktop-system;
          pkgs = desktop-pkgs;
        };

    };
  };

}
