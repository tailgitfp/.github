{
  description = "Home configuration of pub";

  inputs = {
    # nixos = {
    #   url = https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
    # };
    nixpkgs = {
      url = github:NixOS/nixpkgs/nixpkgs-unstable;
      inputs.nixpkgs.follows = "nixos";
    };
    nurpkgs = {
      url = github:nix-community/NUR;
      #override
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };

  outputs = inputs @ { self, nixpkgs, nurpkgs, home-manager }:
    let
      system = "x86_64-linux";
      username = "pub";
      homeDirectory = "/home/${username}";
      configHome = "${homeDirectory}/.config";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.xdg.configHome = configHome;
        overlays = [ nurpkgs.overlay ];
      };

      nur = import nurpkgs {
        inherit pkgs;
        nurpkgs = pkgs;
      };
      
      #pkgs = nixpkgs.legacyPackages.${system};
    in
      {
        main = home-manager.lib.homeManagerConfiguration rec {
          inherit pkgs system username homeDirectory;

          stateVersion = "23.05";
          #could be a module , so can be confguration.nix
          configuration = import ./home.nix {
            inherit nur pkgs;
            inherit (pkgs) config lib stdenv;
          };
        };
      };
}
        
      

