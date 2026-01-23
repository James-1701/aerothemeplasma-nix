{
  stdenvNoCC,
  aerothemeplasma,
  ATPdate
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-cursors";
  src = aerothemeplasma;
  version = ATPdate;

  unpackPhase = "tar -xzf $src/misc/cursors/aero-drop.tar.gz";
  installPhase = "mkdir -p $out/share/icons && cp -r aero-drop $out/share/icons";
}