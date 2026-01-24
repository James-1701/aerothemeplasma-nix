{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-win7showdesktop";
  version = "2025-06-21";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = "mkdir -p $out/share/plasma/plasmoids
  cp $src/plasma/plasmoids/io.gitgud.wackyideas.win7showdesktop $out/share/plasma/plasmoids";
}