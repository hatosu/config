{ config, pkgs, inputs, ... }: {

  # import drivers for ga402x asus laptop
  imports = [
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga402x-amdgpu
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga402x-nvidia
  ];

  # xserver gpu
  services.xserver.videoDrivers = [ "nvidia" ];

  # proprietary drivers are faster
  hardware.nvidia.open = false;

}
