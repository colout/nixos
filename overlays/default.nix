# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  overlay-unstable = final: prev: { 
    unstable = import nixpkgs-unstable {
      system = "x86_64-linux"; 
      config.allowUnfree = true;
    };
  };

  overlay-stable = final: prev: { 
    stable = import nixpkgs-stable {
      system = "x86_64-linux"; 
      config.allowUnfree = true;
    };
  };
}
