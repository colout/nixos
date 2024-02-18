{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.xserver = {
    videoDrivers = ["nvidia"];
  };

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_MaxFramesAllowed = "0";
  };

  hardware = {
    opengl.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;

      package = config.boot.kernelPackages.nvidiaPackages.production;

      open = false;
    };
  };
}
