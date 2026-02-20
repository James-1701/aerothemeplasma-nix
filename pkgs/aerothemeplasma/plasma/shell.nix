{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-shell";
  version = "2025-11-15";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plasma/shells
    cp -r $src/plasma/shells/io.gitgud.wackyideas.desktop $out/share/plasma/shells
    runHook postInstall
  '';
}