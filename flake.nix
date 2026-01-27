{
  description = "AeroThemePlasma on NixOS";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ withSystem, self, ... }: {
      systems = [ "x86_64-linux" "aarch64-linux" "i686-linux" ];

      flake.overlays.default = final: prev:
        withSystem prev.stdenv.hostPlatform.system ({config, ...}: {
          kdePackages = prev.kdePackages.overrideScope (kfinal: kprev: {
            libplasma = kprev.libplasma.overrideAttrs (oldAttrs: {
              postUnpack = "cp -r ${config.packages.aerothemeplasma}/misc/libplasma/src src";
            });
          });
        });

      perSystem = { pkgs, system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [self.overlays.default];
        };

        packages = pkgs.lib.filterAttrs (_: pkgs.lib.isDerivation) (
          pkgs.lib.makeScope pkgs.newScope (self: {
            aerothemeplasma = pkgs.fetchFromGitLab {
              domain = "gitgud.io";
              owner = "wackyideas";
              repo = "AeroThemePlasma";
              rev = "9c9d4f2a4e84319351428b8b13f84eb0eb4e2ada";
              hash = "sha256-fXxNDNm5dFRr5g3k0alEsoc83wyKMIt9Ud/yFOCT3II=";
            };
            cursors = self.callPackage ./pkgs/assets/cursors.nix {};
            icons = self.callPackage ./pkgs/assets/icons.nix {};
            sounds = self.callPackage ./pkgs/assets/sounds.nix {};

            segoe-ui = self.callPackage ./pkgs/fonts/segoe-ui.nix {};
            lucida-console = self.callPackage ./pkgs/fonts/lucida-console.nix {};

            authui7 = self.callPackage ./pkgs/plasma/authui7.nix {};
            color-scheme = self.callPackage ./pkgs/plasma/color-scheme.nix {};
            kvantum = self.callPackage ./pkgs/plasma/kvantum.nix {};
            layout-template = self.callPackage ./pkgs/plasma/layout-template.nix {};
            seven-black = self.callPackage ./pkgs/plasma/seven-black.nix {};

            keyboardlayout = self.callPackage ./pkgs/plasmoids/keyboardlayout.nix {};
            win7showdesktop = self.callPackage ./pkgs/plasmoids/win7showdesktop.nix {};

            linver = self.callPackage ./pkgs/software/linver.nix {};

            login-sessions = self.callPackage ./pkgs/system/login-sessions.nix {};
          })
        );
      };
    });
}
