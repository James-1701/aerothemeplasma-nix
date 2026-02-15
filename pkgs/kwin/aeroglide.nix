{
  stdenv,
  aerothemeplasma,
  kdePackages,
  pkg-config,
  cmake,
  lib
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-aeroglide";
  version = "2025-12-19";
  src = aerothemeplasma;

  preConfigure = "cd kwin/effects_cpp/aeroglide";
  buildInputs = with kdePackages; [ kwin qttools ];
  nativeBuildInputs = [ cmake pkg-config kdePackages.wrapQtAppsHook ];
  cmakeFlags = [ (lib.cmakeBool "KWIN_BUILD_WAYLAND" true) ];
}