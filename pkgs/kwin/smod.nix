{
  stdenv,
  aerothemeplasma,
  kdePackages,
  libplasma,
  pkg-config,
  cmake,
  lib
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-smod";
  version = "2025-11-24";
  src = aerothemeplasma;

  preConfigure = "cd kwin/decoration";
  patches = [ ../../patches/smod-xdg.patch ];
  buildInputs = with kdePackages; [
    extra-cmake-modules qtbase kirigami
    kcoreaddons kcolorscheme kguiaddons
    ki18n kiconthemes kwindowsystem
    kdecoration kcmutils
  ];
  nativeBuildInputs = [ cmake pkg-config kdePackages.wrapQtAppsHook ];
  postFixup = "rm -rf $out/share/locale && mkdir -p $out/share && cp -r $src/kwin/smod $out/share";
}