{
  description = "AeroThemePlasma on NixOS";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ withSystem, self, ... }: {
      systems = [ "x86_64-linux" "aarch64-linux" "i686-linux" ];

      perSystem = { pkgs, system, ... }: {
        packages = pkgs.lib.filterAttrs (_: pkgs.lib.isDerivation) (
          pkgs.lib.makeScope pkgs.newScope (self: {
            aerothemeplasma = pkgs.fetchFromGitLab {
              domain = "gitgud.io";
              owner = "wackyideas";
              repo = "AeroThemePlasma";
              rev = "d3b1e1eb11d5f43a6e9cbbf6a38f404d9587dbba";
              hash = "sha256-36lz9E7JsTGWytJI6qk4XKUvwIQKqLBG/W/OBMgdO/4=";
            };
            libplasma = pkgs.kdePackages.libplasma.overrideAttrs (oldAttrs: {
              pname = "aerothemeplasma-libplasma";
              postPatch = ''
                shopt -s globstar
                cp -r ${self.aerothemeplasma}/misc/libplasma/src .

                substituteInPlace src/**/CMakeLists.txt \
                  --replace-warn 'URI "org.kde.plasma.' 'URI "io.gitgud.wackyideas.plasma.' \
                  --replace-warn "EXPORT_NAME Plasma" "OUTPUT_NAME ATPlasma"
                substituteInPlace src/**/*.qml --replace-quiet "import org.kde.plasma." "import io.gitgud.wackyideas.plasma."

                substituteInPlace src/declarativeimports/CMakeLists.txt --replace-fail "add_subdirectory(kirigamiplasmastyle)" ""
                substituteInPlace src/plasma/CMakeLists.txt --replace-fail "add_subdirectory(packagestructure)" ""
              '';
              ninjaFlags = ["corebindingsplugin"];
              postFixup = "rm -rf $out/share";
            });

            cursors = self.callPackage ./pkgs/assets/cursors.nix {};
            icons = self.callPackage ./pkgs/assets/icons.nix {};
            sounds = self.callPackage ./pkgs/assets/sounds.nix {};

            segoe-ui = self.callPackage ./pkgs/fonts/segoe-ui.nix {};
            lucida-console = self.callPackage ./pkgs/fonts/lucida-console.nix {};

            aeroglassblur = self.callPackage ./pkgs/kwin/aeroglassblur.nix {};
            smod = self.callPackage ./pkgs/kwin/smod.nix {};
            smodglow = self.callPackage ./pkgs/kwin/smodglow.nix {};

            authui7 = self.callPackage ./pkgs/plasma/authui7.nix {};
            color-scheme = self.callPackage ./pkgs/plasma/color-scheme.nix {};
            kvantum = self.callPackage ./pkgs/plasma/kvantum.nix {};
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
          })
        );
      };
    });
}
