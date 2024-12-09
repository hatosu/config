{pkgs, ...}: {
  boot = {
    # bootloader
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # kernel
    kernelPackages = pkgs.linuxPackages_latest; # backup: pkgs.latest.linuxPackages;
  };
}
