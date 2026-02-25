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
    mkdir -p $out/share/Kvantum/Windows7Aero
    cp $src/misc/kvantum/Windows7Aero/Windows7Aero.svg $out/share/Kvantum/Windows7Aero

    # for Sevulet Stickies to not render with a transparent background
    sed \
      's/^opaque=.*/&,stickies/' \
      $src/misc/kvantum/Windows7Aero/Windows7Aero.kvconfig \
      > $out/share/Kvantum/Windows7Aero/Windows7Aero.kvconfig
      
    runHook postInstall
  '';
}