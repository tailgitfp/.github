{
  description = "NixOS configuration";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = inputs @ { self, nixpkgs }:
    let system = "x86_64-linux"; in {
      nixosConfigurations = {
        optiplex = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./machine/optiplex
            ./configuration.nix
          ];
        };
      };
    };
}
