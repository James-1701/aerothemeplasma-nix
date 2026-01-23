This flake is not ready for public use and only has [a few cheap packages](pkgs).

## Installation
### Fonts
The `segoe-ui` and `lucida-console` packages require font files from an up-to-date install of Windows 7, found in C:\Windows\Fonts. To check the font version, use `fc-query -f "%{fontversion}" FILE.ttf`.

* Segoe UI: segoeui.ttf (336200), segoeuib.ttf (336200), segoeuii.ttf (336200), seguisb.ttf (327680)
* Lucida Console: lucon.ttf (327680)

Add files to the Nix store with `nix store add-file FILE.ttf`.