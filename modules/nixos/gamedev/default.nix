{
  config,
  lib,
  ...
}: {
  # for manually installing ue5's epic asset manager with:
  #   flatpak run io.github.achetagames.epic_asset_manager
  services.flatpak = {
    enable = true;
  };
}
