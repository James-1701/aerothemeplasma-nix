{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-color-scheme";
  version = "2025-11-14";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/color-schemes
    cp $src/plasma/color_scheme/Aero.colors $out/share/color-schemes
    runHook postInstall
  '';
}