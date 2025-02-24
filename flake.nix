{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      #url = "github:nix-community/home-manager/release-23.11";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    overlays = import ./overlays {inherit inputs;};

    # Machine configs
    nixosConfigurations = {
      xiangbing = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};

        modules = [
          ./hosts/xiangbing/configuration.nix
          ./hosts/xiangbing/hardware-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs;};
              users = {"colout" = import ./home-manager/colout.nix;};
            };
          }
        ];
      };
      minilab01 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};

        modules = [
          ./hosts/minilab01/configuration.nix
          ./hosts/minilab01/hardware-configuration.nix

          #home-manager.nixosModules.home-manager
          #{
          #  home-manager = {
          #    extraSpecialArgs = {inherit inputs;};
          #    users = {"colout" = import ./home-manager/colout-minimal.nix;};
          #  };
          #}
        ];
      };
    };
  };
}
