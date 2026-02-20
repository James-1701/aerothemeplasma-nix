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
  pname = "aerothemeplasma-smodglow";
  version = "2025-10-22";
  src = aerothemeplasma;

  preConfigure = "cd kwin/effects_cpp/smodglow";
  buildInputs = with kdePackages; [ kwin smod ];
  nativeBuildInputs = [ cmake pkg-config kdePackages.wrapQtAppsHook ];
  cmakeFlags = [ (lib.cmakeBool "KWIN_BUILD_WAYLAND" true) ];
}