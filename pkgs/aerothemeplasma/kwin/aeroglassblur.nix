{
  stdenv,
  aerothemeplasma,
  kdePackages,
  pkg-config,
  cmake,
  lib
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-aeroglassblur";
  version = "2025-11-04";
  src = aerothemeplasma;

  preConfigure = "cd kwin/effects_cpp/kde-effects-aeroglassblur";
  buildInputs = with kdePackages; [ kwin qttools ];
  nativeBuildInputs = [ cmake kdePackages.wrapQtAppsHook ];
  cmakeFlags = [ (lib.cmakeBool "KWIN_BUILD_WAYLAND" true) ];
}