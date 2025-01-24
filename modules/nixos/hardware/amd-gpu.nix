{
  config,
  pkgs,
  ...
}: {
  boot.initrd.kernelModules = ["amdgpu"];

  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  environment.systemPackages = with pkgs; [
    clinfo
  ];
}
