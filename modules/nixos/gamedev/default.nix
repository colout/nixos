{
  outputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    outputs.overlays.additions
  ];

  environment.systemPackages = [
    pkgs.additions.terraform-graph-beautifier
  ];
  # for manually installing ue5's epic asset manager with:
  #   flatpak run io.github.achetagames.epic_asset_manager
  services.flatpak = {
    enable = true;
  };
}
