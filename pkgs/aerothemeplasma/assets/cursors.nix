{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-cursors";
  version = "2024-08-09";
  src = aerothemeplasma;

  unpackPhase = ''
    runHook preUnpack
    tar -xzf $src/misc/cursors/aero-drop.tar.gz
    runHook postUnpack
  '';
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons
    cp -r aero-drop $out/share/icons
    runHook postInstall
  '';
}