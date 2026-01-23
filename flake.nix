{
  description = "AeroThemePlasma on NixOS";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    let ATPdate = "2026-01-23"; in flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "i686-linux" ];
      perSystem = { pkgs, ... }: {
        packages = pkgs.lib.makeScope pkgs.newScope (self: {
          # Microsoft fonts
          segoe-ui = self.callPackage ./pkgs/fonts/segoe-ui.nix {};
          lucida-console = self.callPackage ./pkgs/fonts/lucida-console.nix {};

          # AeroThemePlasma assets
          aerothemeplasma = pkgs.fetchFromGitLab {
            domain = "gitgud.io";
            owner = "wackyideas";
            repo = "AeroThemePlasma";
            rev = "09696c50230cede7eccb1c67c7d0e92d7af1663f";
            hash = "sha256-6BzDw43bgI08BTEIogDdP2lLCaj7in2DFp4ButFJRWo=";
          };
          cursors = self.callPackage ./pkgs/assets/cursors.nix {inherit ATPdate;};
        });
      };
    };
}
