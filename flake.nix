{
  description = "AeroThemePlasma on NixOS";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "i686-linux" ];
      perSystem = { pkgs, ... }: {
        packages.segoe-ui = pkgs.callPackage ./pkgs/fonts/segoe-ui.nix {};
        packages.lucida-console = pkgs.callPackage ./pkgs/fonts/lucida-console.nix {};
      };
    };
}
