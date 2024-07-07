{
  outputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    outputs.overlays.additions
    outputs.overlays.packages-stable
  ];

  environment.systemPackages = [
    #pkgs.stable.terraform
    pkgs.terraform-graph-beautifier
  ];

  # for manually installing ue5's epic asset manager with:
  #   flatpak run io.github.achetagames.epic_asset_manager
  services.flatpak = {
    enable = true;
  };
}
