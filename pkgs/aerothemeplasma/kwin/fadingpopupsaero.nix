{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-fadingpopupsaero";
  version = "2025-10-22";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/kwin/effects
    cp -r $src/kwin/effects/fadingpopupsaero $out/share/kwin/effects
    runHook postInstall
  '';
}