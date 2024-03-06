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

outputs = { self, nixpkgs, nixpkgs-stable, nixpkgs-unstable, hyprland, ... }@inputs: 
  let
    overlays = import ./overlays {inherit inputs;};
  in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [ 
        (import ./configuration.nix {inherit overlay-stable overlay-unstable;})
        (import ./modules/wm/hyprland.nix {inherit overlay-stable overlay-unstable;})
        (import ./modules/games.nix {inherit overlay-stable overlay-unstable;})
        (import ./modules/wm/kde.nix {inherit overlay-stable overlay-unstable;})
        
        ./modules/hardware/nvidia.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
