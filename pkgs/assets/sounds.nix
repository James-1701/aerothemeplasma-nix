{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-sounds";
  version = "2025-08-03";
  src = aerothemeplasma;

  unpackPhase = "tar -xzf $src/misc/sounds/sounds.tar.gz";
  installPhase = "mkdir -p $out/share/sounds
  cp -r Windows* $out/share/sounds";
}