{
  stdenv,
  aerothemeplasma,
  kdePackages,
  pkg-config,
  smod,
  cmake,
  lib
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-smodsnap";
  version = "2025-10-22";
  src = aerothemeplasma;

  preConfigure = "cd kwin/effects_cpp/kwin-effect-smodsnap-v2";
  buildInputs = with kdePackages; [ kwin qttools smod ];
  nativeBuildInputs = [ cmake pkg-config kdePackages.wrapQtAppsHook ];
  cmakeFlags = [ (lib.cmakeBool "KWIN_BUILD_WAYLAND" true) ];
}