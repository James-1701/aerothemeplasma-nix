{
  stdenvNoCC,
  aerothemeplasma-repo
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-panel";
  version = "2026-02-28";
  src = aerothemeplasma-repo;

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plasma/plasmoids
    cp -r $src/plasma/plasmoids/io.gitgud.wackyideas.panel $out/share/plasma/plasmoids
    runHook postInstall
  '';
}