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
            libplasma = self.callPackage ./pkgs/hacks/libplasma.nix {};
            plasma-workspace = self.callPackage ./pkgs/hacks/plasma-workspace.nix {};

            cursors = self.callPackage ./pkgs/assets/cursors.nix {};
            icons = self.callPackage ./pkgs/assets/icons.nix {};
            sounds = self.callPackage ./pkgs/assets/sounds.nix {};

            segoe-ui = self.callPackage ./pkgs/fonts/segoe-ui.nix {};
            lucida-console = self.callPackage ./pkgs/fonts/lucida-console.nix {};

            aeroglassblur = self.callPackage ./pkgs/kwin/aeroglassblur.nix {};
            aeroglide = self.callPackage ./pkgs/kwin/aeroglide.nix {};
            dimscreenaero = self.callPackage ./pkgs/kwin/dimscreenaero.nix {};
            fadingpopupsaero = self.callPackage ./pkgs/kwin/fadingpopupsaero.nix {};
            flip3d = self.callPackage ./pkgs/kwin/flip3d.nix {};
            launchfeedback = self.callPackage ./pkgs/kwin/launchfeedback.nix {};
            loginaero = self.callPackage ./pkgs/kwin/loginaero.nix {};
            smod = self.callPackage ./pkgs/kwin/smod.nix {};
            smodsnap = self.callPackage ./pkgs/kwin/smodsnap.nix {};
            smodglow = self.callPackage ./pkgs/kwin/smodglow.nix {};
            squashaero = self.callPackage ./pkgs/kwin/squashaero.nix {};
            thumbnail-seven = self.callPackage ./pkgs/kwin/thumbnail-seven.nix {};

            authui7 = self.callPackage ./pkgs/plasma/authui7.nix {};
            color-scheme = self.callPackage ./pkgs/plasma/color-scheme.nix {};
            kcmloader = self.callPackage ./pkgs/plasma/kcmloader.nix {};
            kvantum-windows7aero = self.callPackage ./pkgs/plasma/kvantum-windows7aero.nix {};
            layout-template = self.callPackage ./pkgs/plasma/layout-template.nix {};
            seven-black = self.callPackage ./pkgs/plasma/seven-black.nix {};
            shell = self.callPackage ./pkgs/plasma/shell.nix {};

            desktopcontainment = self.callPackage ./pkgs/plasmoids/desktopcontainment.nix {};
            digitalclocklite = self.callPackage ./pkgs/plasmoids/digitalclocklite.nix {};
            keyboardlayout = self.callPackage ./pkgs/plasmoids/keyboardlayout.nix {};
            notifications = self.callPackage ./pkgs/plasmoids/notifications.nix {};
            panel = self.callPackage ./pkgs/plasmoids/panel.nix {};
            sevenstart = self.callPackage ./pkgs/plasmoids/sevenstart.nix {};
            seventasks = self.callPackage ./pkgs/plasmoids/seventasks.nix {};
            systemtray = self.callPackage ./pkgs/plasmoids/systemtray.nix {};
            volume = self.callPackage ./pkgs/plasmoids/volume.nix {};
            win7showdesktop = self.callPackage ./pkgs/plasmoids/win7showdesktop.nix {};

            aeroglasspane = self.callPackage ./pkgs/software/aeroglasspane.nix {};
            linver = self.callPackage ./pkgs/software/linver.nix {};

            login-session = self.callPackage ./pkgs/system/login-session.nix {};
            plymouthvista = self.callPackage ./pkgs/system/plymouthvista.nix {};
            sddm-theme-mod = self.callPackage ./pkgs/system/sddm-theme-mod.nix {};
          })
        );
      };
    });
}