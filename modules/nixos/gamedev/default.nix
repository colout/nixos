{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.home.apps.flatpak;
in {
  options.modules.home.apps.flatpak = {
    enable = mkEnableOption ''
      Enable flatpak with my custom configurations
    '';
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;

      update.onActivation = true;

      packages = [
        {
          appId = "io.github.achetagames.epic_asset_manager";
          origin = "flathub";
        }
      ];
    };
  };
}
