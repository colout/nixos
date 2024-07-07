{
  outputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    outputs.overlays.modifications
  ];

  environment.systemPackages = [
    pkgs.modifications.terraform-graph-beautifier
  ];

  # for manually installing ue5's epic asset manager with:
  #   flatpak run io.github.achetagames.epic_asset_manager
  services.flatpak = {
    enable = true;
  };
}
