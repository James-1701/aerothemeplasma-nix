{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-flip3d";
  version = "2025-10-22";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/kwin/tabbox
    cp -r $src/kwin/tabbox/flip3d $out/share/kwin/tabbox
    runHook postInstall
  '';
}