{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-panel";
  version = "2025-10-21";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plasma/plasmoids
    cp -r $src/plasma/plasmoids/io.gitgud.wackyideas.panel $out/share/plasma/plasmoids
    runHook postInstall
  '';
}