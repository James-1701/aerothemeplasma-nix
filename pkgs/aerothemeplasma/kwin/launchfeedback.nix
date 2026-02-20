{
  stdenv,
  aerothemeplasma,
  kdePackages,
  pkg-config,
  cmake,
  lib
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-launchfeedback";
  version = "2025-10-22";
  src = aerothemeplasma;

  preConfigure = "cd kwin/effects_cpp/startupfeedback";
  buildInputs = with kdePackages; [ kwin qttools ];
  nativeBuildInputs = [ cmake pkg-config kdePackages.wrapQtAppsHook ];
  cmakeFlags = [ (lib.cmakeBool "KWIN_BUILD_WAYLAND" true) ];
}