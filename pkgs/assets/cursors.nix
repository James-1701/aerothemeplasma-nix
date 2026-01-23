{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-cursors";
  version = "2024-08-09";
  src = aerothemeplasma;

  unpackPhase = "tar -xzf $src/misc/cursors/aero-drop.tar.gz";
  installPhase = "mkdir -p $out/share/icons && cp -r aero-drop $out/share/icons";
}