{
  description = "ratpac-two";

  inputs = {
    nixpkgs    .url = "github:nixos/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:

    flake-utils.lib.eachDefaultSystem(system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.ratpac-two = pkgs.callPackage ./packages/ratpac-two.nix {};

        devShells.default = pkgs.mkShell {
          inputsFrom = [ self.packages.${system}.ratpac-two ];
        };
      });
}
