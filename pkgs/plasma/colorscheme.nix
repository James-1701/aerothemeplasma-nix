{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-colorscheme";
  version = "2025-11-14";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = "mkdir -p $out/share/color-schemes
  cp $src/plasma/color_scheme/Aero.colors $out/share/color-schemes";
}