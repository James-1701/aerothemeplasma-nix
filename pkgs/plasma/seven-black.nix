{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-seven-black";
  version = "2025-10-23";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plasma/desktoptheme
    cp -R $src/plasma/desktoptheme/Seven-Black $out/share/plasma/desktoptheme
    runHook postInstall
  '';
}