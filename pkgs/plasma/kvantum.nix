{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-kvantum";
  version = "2025-12-30";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = "mkdir -p $out/share/Kvantum
  cp -r $src/misc/kvantum/Kvantum/Windows7Aero $out/share/Kvantum";
}