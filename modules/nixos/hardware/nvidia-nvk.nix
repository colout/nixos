{ config, pkgs, ... }: {
  services.xserver = { videoDrivers = [ "nvidia" ]; };

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_MaxFramesAllowed = "0";
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;

      package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;

      open = false;
    };
  };

  environment.systemPackages = with pkgs; [ vaapiVdpau egl-wayland ];
}
