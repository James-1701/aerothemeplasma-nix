{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-squashaero";
  version = "2025-10-22";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/kwin/effects
    cp -r $src/kwin/effects/squashaero $out/share/kwin/effects
    runHook postInstall
  '';
}