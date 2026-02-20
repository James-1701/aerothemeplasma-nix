{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-icons";
  version = "2025-07-15";
  src = aerothemeplasma;

  unpackPhase = ''
    runHook preUnpack
    tar -xzf "$src/misc/icons/Windows 7 Aero.tar.gz"
    runHook postUnpack
  '';
  installPhase = ''
    runHook preUnpack
    mkdir -p $out/share/icons
    cp -r 'Windows 7 Aero' $out/share/icons
    runHook postUnpack
  '';
}