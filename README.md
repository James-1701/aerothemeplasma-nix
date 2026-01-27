This flake is highly unfinished and exposes [some basic packages](pkgs).

## Installation
### Fonts
The segoe-ui and lucida-console packages require font files from an up-to-date install of Windows 7, found in C:\Windows\Fonts. To check the font version, use `fc-query -f "%{fontversion}" FILE.ttf`.

* Segoe UI: segoeui.ttf (336200), segoeuib.ttf (336200), segoeuii.ttf (336200), seguisb.ttf (327680)
* Lucida Console: lucon.ttf (327680)

Add files to the Nix store with `nix store add-file FILE.ttf`.

### libplasma overlay
AeroThemePlasma needs a custom libplasma for certain plasmoids. There's an overlay for this, but if the theme or Plasma updates, you get rebuilds that take over an hour :(
```nix
nixpkgs.overlays = [ inputs.aerothemeplasma-nix.overlays.default ];
```