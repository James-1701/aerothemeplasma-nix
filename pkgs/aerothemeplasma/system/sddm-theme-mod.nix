{
  stdenvNoCC,
  aerothemeplasma-repo
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-sddm-theme-mod";
  version = "2025-10-04";
  src = aerothemeplasma-repo;

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/sddm/themes
    cp -r $src/plasma/sddm/sddm-theme-mod $out/share/sddm/themes
    runHook postInstall
  '';
}