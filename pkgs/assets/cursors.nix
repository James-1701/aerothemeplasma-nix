{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-cursors";
  version = aerothemeplasma.rev;
  src = aerothemeplasma;

  unpackPhase = "tar -xzf $src/misc/cursors/aero-drop.tar.gz";
  installPhase = "mkdir -p $out/share/icons && cp -r aero-drop $out/share/icons";
}