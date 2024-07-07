{
  outputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    outputs.overlays.additions
  ];

  environment.systemPackages = [
    # this is broken (some terraform graph example thing), but you can try to build out a nixpkg for this
    #pkgs.ue5_4_2
  ];

  # for manually installing ue5's epic asset manager with:
  #   flatpak run io.github.achetagames.epic_asset_manager
  services.flatpak = {
    enable = true;
  };
}
