{
  stdenvNoCC,
  lib,
  aerothemeplasma-repo,
  atpootb
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-xdg";
  version = "2026-02-23";
  src = aerothemeplasma-repo;

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    shopt -s extglob
    mkdir -p $out/share/aerothemeplasma/branding $out/etc/xdg

    cp $src/misc/branding/kcminfo.png $out/share/aerothemeplasma/branding
    cp $src/misc/xdg/!(autostart|CMakeLists.txt) $out/etc/xdg
    # the one autostart, atpootb, is part of the atpootb package instead. the
    # CMakeLists.txt is excluded as I have no idea what sorts of fun stuff will
    # happen if you have *that* included in your xdg configs. likely nothing, but 
    # wouldn't want to debug that one
    
    substituteInPlace $out/etc/xdg/kcm-about-distrorc \
      --replace-fail "/usr/share/aerothemeplasma" "$out/share/aerothemeplasma"

    runHook postInstall
  '';
}