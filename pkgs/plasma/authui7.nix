{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-authui7";
  version = "2025-10-26";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = "mkdir -p $out/share/plasma/look-and-feel
  cp -r $src/plasma/look-and-feel/authui7 $out/share/plasma/look-and-feel";
}