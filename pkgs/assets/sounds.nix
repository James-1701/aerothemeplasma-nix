{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-sounds";
  version = "2025-08-03";
  src = aerothemeplasma;

  unpackPhase = ''
    runHook preUnpack
    tar -xzf $src/misc/sounds/sounds.tar.gz
    runHook postUnpack
  '';
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/sounds
    cp -r Windows* $out/share/sounds
    runHook postInstall
  '';
}