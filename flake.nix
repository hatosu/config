{ description = "Hatosu's NixOS flake.";

  inputs = {

    # default (new packages)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # fresh (newer packages)
    nixpkgs-fresh.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # latest (newest packages)
    nixpkgs-latest.url = "github:nixos/nixpkgs?ref=master";

    # stable (old packages)
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # pinned (wont update)
    nixpkgs-pinned.url = "github:nixos/nixpkgs/f83f99270023d739b4ab3fa51f39778165bb4920";

    # home manager
    home-manager = {
      url = "github:nix-community/home-manager/e83414058edd339148dc142a8437edb9450574c8";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # disko
    disko = {
      url = "github:nix-community/disko/67dc29be3036cc888f0b9d4f0a788ee0f6768700";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # firefox addons
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons&ref=610a9c92c573bf57959ffd371cb4921dd681b272";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spicetify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix/396cf13f9310aa82c1a5da24a5213e7170d40642";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # impermanence
    impermanence.url = "github:nix-community/impermanence/c7f5b394397398c023000cf843986ee2571a1fd7";

    # nixos hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/59b6e11bea99805b02ab38c8f9d8ba21fee58874";

  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... } @ inputs: let
    
    strings = import ./misc/strings/default.nix;
    
    systems = [ "x86_64-linux" ];
    
    forAllSystems = nixpkgs.lib.genAttrs systems;

    shellpkgs = nixpkgs.legacyPackages.x86_64-linux;
  
  in {
    
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});  
    
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    
    overlays = import ./overlay {inherit inputs;};
    
    nixosModules = import ./module/nix;
    
    homeManagerModules = import ./module/home;
    
    devShells.x86_64-linux.default = (import ./shell.nix {inherit shellpkgs;});
    
    nixosConfigurations = {

      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs; inherit strings;};
        modules = [
          ./profile/laptop/configuration.nix
          home-manager.nixosModules.home-manager
          inputs.home-manager.nixosModules.default
          inputs.disko.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
          inputs.spicetify-nix.nixosModules.default
        ];
      };

      server1 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs; inherit strings;};
        modules = [
          ./profile/server1/configuration.nix
          inputs.disko.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
        ];
      };

      proj1 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs; inherit strings;};
        modules = [
          ./profile/proj1/configuration.nix
          inputs.disko.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
        ];
      };

      temporary = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs; inherit strings;};
        modules = [
          ./profile/temporary/configuration.nix
          inputs.disko.nixosModules.default
        ];
      };

    };
  };
}
