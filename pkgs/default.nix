pkgs: {

  # utils
  nixfind          = pkgs.callPackage ./nixfind          {};
  help             = pkgs.callPackage ./help             {};
  nixocr           = pkgs.callPackage ./nixocr           {};
  wallpaper        = pkgs.callPackage ./wallpaper        {};

  # games
  plutonium        = pkgs.callPackage ./plutonium        {};
  ddlc             = pkgs.callPackage ./ddlc             {};
  holocure         = pkgs.callPackage ./holocure         {};

}
