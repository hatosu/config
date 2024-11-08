{ pkgs, inputs, ... }: {

  # setup steam
  programs.gamemode.enable = true;
  environment.defaultPackages = [ pkgs.mangohud ];
  programs.steam = { enable = true;
  extraPackages = with pkgs; [ gamescope ];
  extraCompatPackages = with pkgs; [ proton-ge-bin ]; };

  # game packages
  environment.systemPackages = with pkgs; [
    minecraft
    cemu
    ddlc
    holocure
  ];

  # support for xbox controller usb dongle
  hardware.xone.enable = true;

}
