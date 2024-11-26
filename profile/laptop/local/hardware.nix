{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  ...
}:
{

  imports = [

    # import drivers for ga402x asus laptop
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga402x-amdgpu
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga402x-nvidia

    # generated by nix
    (modulesPath + "/installer/scan/not-detected.nix")

  ];

  # xserver gpu
  services.xserver.videoDrivers = [ "nvidia" ];

  # proprietary drivers are faster
  hardware.nvidia.open = false;

  # graphics
  hardware = {
    firmware = [ pkgs.firmwareLinuxNonfree ];
    enableAllFirmware = true;
    nvidia-container-toolkit.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      #  extraPackages = [ pkgs.stable.rocmPackages.clr.icd ];
    };
  };

  # also generated by nix
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usb_storage"
    "usbhid"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}
