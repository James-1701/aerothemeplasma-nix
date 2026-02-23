{
  stdenvNoCC,
  aerothemeplasma-repo
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-kvantum-windows7aero";
  version = "2026-02-21";
  src = aerothemeplasma-repo;

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/Kvantum
    cp -r $src/misc/kvantum/Windows7Aero $out/share/Kvantum
    runHook postInstall
  '';
}