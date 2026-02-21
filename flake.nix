{
  description = "AeroThemePlasma on NixOS";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ withSystem, moduleWithSystem, ... }: {
      systems = [ "x86_64-linux" "aarch64-linux" "i686-linux" ];

      flake.nixosModules.aerothemeplasma-nix = moduleWithSystem (
        perSystem@{ config }: import ./modules/system.nix perSystem
      );
      flake.homeModules.aerothemeplasma-nix = moduleWithSystem (
        perSystem@{ config }: import ./modules/home.nix perSystem
      );

      perSystem = { pkgs, system, ... }: {
        packages = pkgs.lib.filterAttrs (_: pkgs.lib.isDerivation) (
          pkgs.lib.makeScope pkgs.newScope (self: {
            aerothemeplasma = pkgs.fetchFromGitLab {
              domain = "gitgud.io";
              owner = "wackyideas";
              repo = "AeroThemePlasma";
              rev = "d572194634735a6a727dc71cc4cf1aaf3ca8ce7a";
              hash = "sha256-pET+c0gYO9crdIEoQ/ABLkC7Qd9XJ6D1toonglS+xlE=";
            };
            aerothemeplasma-icons-repo = pkgs.fetchFromGitLab {
              domain = "gitgud.io";
              owner = "aeroshell";
              repo = "atp/aerothemeplasma-icons";
              rev = "44dbe78b76c8b0d55343428b6b179716c36fd7f6";
              hash = "sha256-jBTUgLpxhT/tVB5JTeAcxJ8zNyAK8gffGAiq3fOF1LE=";
            };
            aeroshell-kwin-repo = pkgs.fetchFromGitLab {
              domain = "gitgud.io";
              owner = "aeroshell";
              repo = "aeroshell-kwin-components";
              rev = "326214ef964d24307fdf4482b61ee2001f4d9541";
              hash = "sha256-WOzYDtrIgNQwtifDNbOun324WvKFWcuuvdrG15gOAok=";
            };

            libplasma = self.callPackage ./pkgs/aeroshell/hacks/libplasma.nix {};
            plasma-workspace = self.callPackage ./pkgs/aeroshell/hacks/plasma-workspace.nix {};

            aeroglassblur = self.callPackage ./pkgs/aeroshell/kwin/aeroglassblur.nix {};
            aeroglide = self.callPackage ./pkgs/aeroshell/kwin/aeroglide.nix {};
            dimscreenaero = self.callPackage ./pkgs/aeroshell/kwin/dimscreenaero.nix {};

            cursors = self.callPackage ./pkgs/aerothemeplasma/assets/cursors.nix {};
            icons = self.callPackage ./pkgs/aerothemeplasma/assets/icons.nix {};
            sounds = self.callPackage ./pkgs/aerothemeplasma/assets/sounds.nix {};

            fadingpopupsaero = self.callPackage ./pkgs/aerothemeplasma/kwin/fadingpopupsaero.nix {};
            flip3d = self.callPackage ./pkgs/aerothemeplasma/kwin/flip3d.nix {};
            launchfeedback = self.callPackage ./pkgs/aerothemeplasma/kwin/launchfeedback.nix {};
            loginaero = self.callPackage ./pkgs/aerothemeplasma/kwin/loginaero.nix {};
            smod = self.callPackage ./pkgs/aerothemeplasma/kwin/smod.nix {};
            smodsnap = self.callPackage ./pkgs/aerothemeplasma/kwin/smodsnap.nix {};
            smodglow = self.callPackage ./pkgs/aerothemeplasma/kwin/smodglow.nix {};
            squashaero = self.callPackage ./pkgs/aerothemeplasma/kwin/squashaero.nix {};
            thumbnail-seven = self.callPackage ./pkgs/aerothemeplasma/kwin/thumbnail-seven.nix {};

            authui7 = self.callPackage ./pkgs/aerothemeplasma/plasma/authui7.nix {};
            color-scheme = self.callPackage ./pkgs/aerothemeplasma/plasma/color-scheme.nix {};
            kcmloader = self.callPackage ./pkgs/aerothemeplasma/plasma/kcmloader.nix {};
            kvantum-windows7aero = self.callPackage ./pkgs/aerothemeplasma/plasma/kvantum-windows7aero.nix {};
            layout-template = self.callPackage ./pkgs/aerothemeplasma/plasma/layout-template.nix {};
            seven-black = self.callPackage ./pkgs/aerothemeplasma/plasma/seven-black.nix {};
            shell = self.callPackage ./pkgs/aerothemeplasma/plasma/shell.nix {};

            desktopcontainment = self.callPackage ./pkgs/aerothemeplasma/plasmoids/desktopcontainment.nix {};
            digitalclocklite = self.callPackage ./pkgs/aerothemeplasma/plasmoids/digitalclocklite.nix {};
            keyboardlayout = self.callPackage ./pkgs/aerothemeplasma/plasmoids/keyboardlayout.nix {};
            notifications = self.callPackage ./pkgs/aerothemeplasma/plasmoids/notifications.nix {};
            panel = self.callPackage ./pkgs/aerothemeplasma/plasmoids/panel.nix {};
            sevenstart = self.callPackage ./pkgs/aerothemeplasma/plasmoids/sevenstart.nix {};
            seventasks = self.callPackage ./pkgs/aerothemeplasma/plasmoids/seventasks.nix {};
            systemtray = self.callPackage ./pkgs/aerothemeplasma/plasmoids/systemtray.nix {};
            volume = self.callPackage ./pkgs/aerothemeplasma/plasmoids/volume.nix {};
            win7showdesktop = self.callPackage ./pkgs/aerothemeplasma/plasmoids/win7showdesktop.nix {};

            login-session = self.callPackage ./pkgs/aerothemeplasma/system/login-session.nix {};
            sddm-theme-mod = self.callPackage ./pkgs/aerothemeplasma/system/sddm-theme-mod.nix {};

            segoe-ui = self.callPackage ./pkgs/external/fonts/segoe-ui.nix {};
            lucida-console = self.callPackage ./pkgs/external/fonts/lucida-console.nix {};

            aeroglasspane = self.callPackage ./pkgs/external/software/aeroglasspane.nix {};
            plymouthvista = self.callPackage ./pkgs/external/system/plymouthvista.nix {};
            linver = self.callPackage ./pkgs/external/software/linver.nix {};
          })
        );
      };
    });
}