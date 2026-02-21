{
  stdenv,
  aeroshell-kwin-repo,
  kdePackages,
  pkg-config,
  smod,
  cmake,
  lib
}:
stdenv.mkDerivation {
  pname = "aeroshell-smodsnap";
  version = "2026-02-21";
  src = aeroshell-kwin-repo;

  preConfigure = "cd effects_cpp/wayland/kwin-effect-smodsnap-v2";
  buildInputs = with kdePackages; [ kwin qttools smod ];
  nativeBuildInputs = [ cmake pkg-config kdePackages.wrapQtAppsHook ];
  cmakeFlags = [ (lib.cmakeBool "KWIN_BUILD_WAYLAND" true) ];
}