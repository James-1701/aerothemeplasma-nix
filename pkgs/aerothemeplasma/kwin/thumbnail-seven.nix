{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-thumbnail-seven";
  version = "2025-06-28";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/kwin/tabbox
    cp -r $src/kwin/tabbox/thumbnail_seven $out/share/kwin/tabbox
    runHook postInstall
  '';
}