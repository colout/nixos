{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      #url = "github:nix-community/home-manager/release-23.11";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hycov={
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };
  };

outputs = { self, nixpkgs, home-manager, hyprland, ... } @ inputs: 
  let
    inherit (self) outputs;
  in {
    overlays = import ./overlays {inherit inputs;};

    # Machine configs
    nixosConfigurations = {
      xiangbing = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [ 
          (import ./configuration.nix) 
          (import ./modules/wm/hyprland.nix)
          (import ./modules/games.nix)
          (import ./modules/wm/kde.nix)
          
          ./modules/hardware/nvidia.nix
        ];
      };
    };

    # Home-manager configs
    homeConfigurations = {
      "colout@xiangbing" = home-manager.lib.homeManagerConfigurations {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/home.nix
        ];
      };
    };
  };
}
